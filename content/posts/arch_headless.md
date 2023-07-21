---
title: "Making a headless Arch Linux installation medium"
date: 2023-07-12T11:05:26+02:00
summary: ""
---

Today I needed to install Arch Linux without a display connected to the computer (an old thinkcentre used at [Renn.es](https://renn.es/) for backups). This is a quick tutorial for anyone else who needs to do this. If you encounter problems, please [send me an email](/) so that I can fix this tutorial.

The main thing here is we want to enable the SSH daemon and then add an authorized key for the root account. Then we install Arch the usual way (for example with `archinstall`).

We will be using the `archiso` command line utility on another computer to, well, make an Arch Linux ISO.

If you don't have it already, install it. My workstation runs arch (btw) so I'll use pacman:
```sh
sudo pacman -S archiso
```

Then create a working directory:
```sh
mkdir arch-headless && cd arch-headless
```

We'll use the `releng` profile as a base. From the [wiki](https://wiki.archlinux.org/title/Archiso#Prepare_a_custom_profile):
> releng is used to create the official monthly installation ISO. It can be used as a starting point for creating a customized ISO image.

```sh
cp -r /usr/share/archiso/configs/releng/ .
```

Now you will need an SSH key to add to the authorized_keys file on the ISO. If you don't have one yet, run `ssh-keygen`.
I'll be assuming that the key is in `~/.ssh/id_rsa.pub` as per the default.
```sh
mkdir releng/airootfs/root/.ssh/
cp ~/.ssh/id_rsa.pub releng/airootfs/root/.ssh/authorized_keys
```

And build the ISO (which will probably take a while):
```sh
sudo mkarchiso -v -o ./out ./releng
```

That's it! You should now have an ISO in `./out`.
After making the headless system boot on it, find its IP through an `nmap` or another method. Then you should be able to SSH to `root@<server-ip>` and do the usual `archinstall`.


