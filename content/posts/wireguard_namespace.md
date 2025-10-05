---
title: "Selective wireguard use with a namespace"
date: 2025-10-03
summary: ""
---

Today I decided to make a clean Wireguard client configuration on my dev computer, that would allow accessing any IP with any program while letting any other traffic out without going through it.

I quickly found a [post](https://www.procustodibus.com/blog/2023/04/wireguard-netns-for-specific-apps/) on the infamous [Pro Custodibus blog](https://www.procustodibus.com/blog/), which contains many great Wireguard configs I've used countless times ([Renn.es](https://renn.es/)'s VPS-to-homeserver tunnel couldn't have been done without it).

## Architecture

We will simply create a network namespace `wg0` which will contain the Wireguard interface, so that any traffic in this namespace goes through Wireguard. Userland acces to this namespace will be touched on later.

## Execution

I made a little script that puts everything together (detailed explanations can be found on Custodibus, I won't repeat these):

```sh
#!/usr/bin/env bash

# tunnel: Put wireguard in its own network namespace for selective use.
# Based on [1].
# Used in conjunction with wgx to access the namespace from userspace.
#
# [1]: https://www.procustodibus.com/blog/2023/04/wireguard-netns-for-specific-apps/

set -e

if [ "$1" = "check" ]; then
    ip netns show wg0 | grep -q wg0 || {
        echo "starting tunnel"
        exec doas "$0" up
    }
    exit 0
fi

if [ $EUID -ne 0 ]; then
    echo "Please run this script as root. Exiting."
    exit 1
fi

NAMESPACE=wg0
INTERFACE=wg0

case $1 in
up)
    ip netns add $NAMESPACE         # Create namespace
    ip -n $NAMESPACE link set lo up # Start loopback

    ip link add $INTERFACE type wireguard   # Create empty interface
    ip link set $INTERFACE netns $NAMESPACE # Move into namespace

    # Configure the interface
    ip netns exec $NAMESPACE wg setconf $INTERFACE /etc/wireguard/wg0.conf

    # Set the interface address (matches address in config file)
    ip -n $NAMESPACE address add 10.9.0.2/32 dev $INTERFACE

    ip -n $NAMESPACE link set $INTERFACE up # Start interface

    # Set wg as default route for the namespace
    ip -n $NAMESPACE route add default dev $INTERFACE
    ;;

down)
    ip netns pids $NAMESPACE | xargs -r kill # Kill wireguard
    ip netns delete $NAMESPACE               # Remove namespace
    ;;
esac
```

Note that `/etc/wireguard/wg0.conf` needs to be stripped from its `Address`, `MTU`, `PreUp` and most other `[Interface]` fields, which are already set by the script.

After running `doas ./tunnel up`, the namespace will be usable like this:

```sh
doas ip netns exec wg0 doas -u $(whoami) ssh chorizo
```

But this isn't very convenient, I don't want to have to authenticate locally just to start an SSH session.

## Accessing the namespace from userspace

This is where we'll get our hands dirty, since it requires writing a custom program with the setuid bit set. This is what's used by privilege escalation tools like `sudo`, and it simply allows a program run by a user to run as _effective root_.

It requires additional caution though, as any arbitrary execution that can be done in our program could be used by local bad actors: remember, it's _privilege escalation_. I am pretty serene on this though, because a hacker going through the hassle of finding a mistake in this could simply use a software keylogger to get my root password. I'll still try to make something secure though.

Here's the program. A more recent version may be available [in my dotfiles](https://git.sr.ht/~tarneo/nix/tree/main/item/pkgs/wgx/wgx.c), along with the nix package definition.

```c
// Allow a non-root user to run an arbitrary command in a network namespace,
// useful for a wireguard namespace.

// compile with: gcc -s -o wgx wgx.c
// then run: sudo chmod u+s wgx

// example usage: wgx ip netns identify

// For a cleaner SSH setup, ProxyCommand can be set as follows :
// ProxyCommand = "sh -c 'tunnel check && wgx nc %h %p'";

#define NAME_OF_NETWORK_NAMESPACE  "wg0"
#define PATH_TO_NAMESPACE  "/run/netns/"  NAME_OF_NETWORK_NAMESPACE

#define _GNU_SOURCE

#include <fcntl.h>
#include <sched.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

void
die(int status, char *message) {
	printf("%s\n", message);
	exit(status);
}

int
main(int argc, char **argv) {
	if(!(geteuid() == 0))
		die(3,
		    "This program needs to be run as effective root."
		    "Is the binary owned by root and is the setuid bit set ?");

	int fd = open(PATH_TO_NAMESPACE, O_RDONLY);
	if(fd == -1)
		die(2,
		    "Namespace " NAME_OF_NETWORK_NAMESPACE
		    " does not exist.");
	if(!(setns(fd, CLONE_NEWNET) == 0))
		die(-1, "Couldn't set namespace.");
	if(!(close(fd) == 0))
		die(-1, "Couldn't close ns fd");

	if(!(setgid(getgid()) == 0 && setuid(getuid()) == 0))
		die(-1, "Couldn't drop effective root or root group");

	if(argc > 1)
		execvpe(argv[1], argv + 1, environ);

	printf("A command is needed.");
	return 1;
}
```

This should be pretty self-explanatory to anyone with basic C knowledge. We just check we have effective root, do the namespace change, deescalate privileges and `exec()` the command from arguments.

On NixOS, setting suid can be done as follows (on other OSes, just put the binary in `/bin` after changing owner and setting suid, making sure it is not world-writable):

```sh
security.wrappers.wgx = {
  setuid = true;
  owner = "root";
  group = "root";
  source = "${pkgs.wgx}/bin/wgx";
};
```

This assumes that the script has been compiled into the store as `pkgs.wgx`.

It can then be used instead of `ip netns exec`:

```sh
wgx ssh chorizo
```

## SSH config

I'm editing this post to add that SSH can be easily configured to use this, using ProxyCommand (which replaces SSH's socket connection). Here's the Nix config (the bare SSH config is in `wgx`'s header):

```nix
programs.ssh.matchBlocks."chorizo" = {
  proxyCommand = "sh -c 'tunnel check && wgx nc %h %p'";
};
```

Multiple hostnames can be specified in the quotes, separated by a space.
