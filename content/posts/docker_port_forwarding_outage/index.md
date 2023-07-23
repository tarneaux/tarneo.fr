---
title: "Renn.es Was Down for Eight Hours Because of an Automatic Docker Update"
date: 2023-07-23
summary: "This is why you should never enable automatic routine updates"
---

**tl;dr**: Because we had automatic updates enabled on our Gentoo Linux server, ports couldn't be opened by Docker anymore, which caused 8 hours of downtime. Just running another update fixed the problem.

I have just spend an entire day troubleshooting Docker because of its last version on Gentoo Linux.

## How something went wrong and how I noticed it

I first noticed something was wrong because Syncthing could not connect from my phone to the [Renn.es](https://renn.es/) server.

When I connected, I saw the status of the `syncthing-tarneo` container was `Created`. I though it was just a problem with the latest pull & up of all containers from our docker compose. To better understand this, let's look at a pair of lines from our UID 1000 user:
```sh
0 6 * * * doas emaint --auto sync && doas emerge -uDN @world -j1
0 7 * * * cd ~/services/ && docker compose pull --ignore-pull-failures && docker compose up -d
```
In case you are not familiar with the crontab format, this means the following:
- At 6:00 AM, run an update of all packages, **no matter if it's a security update or not**.
- At 7:00 AM, go to the `~/services` directory (where we have a `docker-compose.yml` tracked with git) and pull all images to get the newest version. Then recreate and start all containers that have a new image (so that we are running the updated version).

I think Syncthing was the only container that didn't start because it was the only one with update. Had it not gotten updates that morning, I would never have found out about the issue in the first place.

## Troubleshooting

Now, here is what `docker logs syncthing` outputted:
```

```
No, it's not a graphical bug. There was nothing logged by Syncthing, which meant that it had not been started after the last docker image update.

Running `docker-compose up -d` showed this error:
```
Error response from daemon: driver failed programming external connectivity on endpoint syncthing-tarneo (<sha256>): Bind for 0.0.0.0:22000 failed: port is already allocated.
```
(I haven't copy-pasted it because I'm too lazy to search in the logs, but I've seen it so many times that I know the text basically by heart :-)

Running tools like `netstat` or `lsof` showed no process using port 22000. So the first thing I tried was restarting the docker daemon, which changed nothing.

Long story short: reinstalling docker, deleting `/var/lib/docker` multiple times to reset docker to its initial state, and even re-installing ALL packages which the docker package depended on (that's 238 packages, which took about two hours to rebuild and reinstall), and some other things I tried changed nothing.

## How I fixed it

In the end, I talked with co-admin *~spedotte* and we decided we'd just move all services to our backup server, which is not running Gentoo but Arch Linux (which apparently doesn't have this issue). It was just after this that I desperately tried to update the Gentoo repository and upgrade packages.

*And what I saw was wonderful.* :-)

There was an update available for both the docker and the containerd packages. I ran through the update, and just after I ran `docker compose up -d`. And *it worked*. All containers started up and after 8 hours of downtime, all of our services were back.

As of writing, there's still one thing that doesn't work: building docker images through `buildx`, which is apparently now the default with docker-compose. This is still showing an error about buildx not being able to find the `containerd.sock` file from inside the container[^1]:
[^1]: See the [full log](buildx-log.txt)
```
#0 14.89 time="2023-07-22T13:45:34Z" level=warning msg="skipping containerd worker, as \"/run/containerd/containerd.sock\" does not exist"
```

I don't really have the time to do this the right way[^2] at the moment but I'll make sure to do it when I can if it's not already fixed then. For now my workaround was using `docker build --tag <image-name> .` for this image, and then changing the docker-compose file to read from that. This causes docker to use the "legacy" build tool which actually works perfectly.


[^2]: The right way to handle this would be to find which piece of software the issue comes from (docker, containerd, buildkit, or maybe just the Gentoo package), and then reporting an issue to that project so that it'd be fixed for everyone.
