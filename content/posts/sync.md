---
title: "How I sync and backup my files"
date: 2024-03-15
summary: ""
---

For a good amount of time now, I've been using a combination of unison, Syncthing and btrfs snapshots for syncing and backing up my files. Here's how it works.

## Syncing files

Whenever my computer is on, I have a script running in the background that runs `unison`, a good mirrored file syncing program, to sync a local `.sync` directory in my home directory with a `sync` directory on the personal account I have on my server.

This syncs everything from my pictures to my notes and my git repositories, which makes for a total size of around 200 GB, maybe more if I have some RAW pictures left from the last time I took photographs.

The notes (composed of my Obsidian vault and my Orgmode directory) are then synced to my mobile phone with Syncthinng. It runs on the server inside of docker, and only has access to the three directories it needs (I also sync the pictures taken on my phone to my server, which in turn syncs them to my computer). This allows my files to be synced to and from my phone even when my computer is off.

## Unison and Rust

If I'm working on a Rust project, Unison gets mad at me for modifying files while they're being synced, which means I have to stop the script and remember to start it again when I'm done (which I forget to do not so uncommonly). This is just a small trade-off I'm willing to live with, but I could also fix it by ignoring the files in the `target/` directory of rust projects.

## Checking if unison is running

I like to see if my files are being synced, in addition to being told when there are errors.

So I very easily added a widget in my awesomeWM bar (I *love* awesome), which just does a `pgrep` and checks that there are at least 4 processes, which is the total count that the script spawns. It's dirty, but it works! (well, at least it works most of the time: if unison keeps exiting because of errors, it tends to alternate between up and down, but that's also a nice way to indicate that something is wrong.)

## Backups

Syncing files to my server which is in a totally different location means I have a back up of the files in case something bad happens with my main computer (a third backup location is underway). The server also does Btrfs snapshots which come at next to no cost, and it allows looking back at what your files were a month ago if you still have the snapshots.

## Moving files I don't need

Sometimes I will have a huge file that I don't want to fill my computer's storage with, and that's also a situation where the server is useful: just `ssh`-ing to it allows me to move said file to a different location, maybe even one that doesn't get snapshotted so that I can save this space. This also allows me to also back up my external hard drives without clogging up snapshots by the way :-)

## Reinstalling Linux

OK, I don't like it, but I reinstall Linux every now and then. This is an operation I will estimate a 6-month to a year frequency from now on, since I'm now using NixOS which will probably be my daily driver for the next few years, and which is super stable (broke the system? Just roll it back!).

When that happens, I like not having to put my data on an external drive. That seems scary too, who'd want to have their data backed up only once or twice a year? So after I've installed the system, I just need to set up unison (and hopefully I still have access to my SSH key or to the server with another computer), sync the files and wait for one or two hours on average, and I'm back to normal.

## Alternative methods

A good alternative to Unison that I considered is git-annex, which allows for much more control on what your files do. You may find it better than unison because of this, but I just found I didn't want to have to think about syncing my files: the background Unison process is what has worked best for me.
