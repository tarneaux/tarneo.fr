---
title: "The Cat S22 flip as a dumbphone"
date: 2025-09-06
summary: "How this Android T9-keyboard phone reduced my screen time"
---

I've now been using a Cat S22 Flip as my daily driver phone for four months.

The reason is simple: I wanted to carry a device that always had battery, was cheap, could run Signal, and wouldn't be an attention magnet. I also wanted the keyboard to always work, even when I was wearing gloves or when my hands were all sweaty. So I went to [dumbphones.org](https://www.dumbphones.org/), and filtered the phones to only see ones that could run Signal, and the Cat S22 flip was the only one which fit all my criteria.

The Cat S22 is an Android phone with a touchscreen and T9 keyboard, with a tiny RAM of 2 GB and 16 GB of storage, paired with an enormous battery which lasts me two days of normal messaging use.

Thanks to much luck (since these phones aren't manufactured anymore), I was able to find one for just 90 euros used immediately. At first, the experience was terrible. I hadn't ever used a phone with stock Android (my trusty galaxy S9 which I have been carrying for years has always been rocking LineageOS from day 1), so I understood how bad it was. Unfortunately, there was no official build of LineageOS for this phone, and I tried reaching a good setup with manual uninstalling of apps.

Eventually I got so tired of the stock ROM that I really searched, and found a [community build](https://xdaforums.com/t/cat-s22-flip-installing-gsi-rom.4660690/) that supported the Cat S22! I jumped on the occasion and installed it. My opinion on this phone quickly changed as I could finally have the stellar LineageOS experience I always loved on my Samsung Galaxy S9. I even could install apps that didn't have support for Android Go !

I started by installing [TT9](https://github.com/sspanak/tt9) to support the T9 keyboard, and went on to install my usual apps: a web browser (Iceraven), Nextcloud, Syncting, DavX5...

All my attempts of using an SD card for music durably with this device have failed, so I've kept my old smartphone only for listening to music. It also doubles as a camera for when I need better quality than the S22's camera, which is only really good in daylight, and lacks exposure in other cases. Qobuz was buggy on the S22 anyway, plus this gives me shared battery usage, which means... Two days of battery life on a phone I used to charge multiple times a day !


## Keypad brightness script

I didn't find a builtin way to power the keyboard when typing or when the screen is on, so I've simply written a bash scripts that runs as a root Termux daemon. You do need rooted android for this, see below.

This script simply watches for events on the T9 keyboard and turns the brightness on for 5 seconds on keypresses.

`~/brightness.sh`:
```bash
#!/bin/bash

DEVICE="/dev/input/event1"
BACKLIGHT="/sys/class/leds/keyboard_light/brightness"
TIMEOUT=5  # seconds

timer_pid=0

turn_on() {
    echo 1 > "$BACKLIGHT"
}

turn_off() {
    echo 0 > "$BACKLIGHT"
}

start_timer() {
    # Kill old timer if it's still running
    if [ "$timer_pid" -ne 0 ] && kill -0 "$timer_pid" 2>/dev/null; then
        kill "$timer_pid" 2>/dev/null
    fi

    (
        sleep "$TIMEOUT"
        turn_off
    ) &

    timer_pid=$!
}

# Main loop: wait for any input event, reset timer
while true; do
    getevent "$DEVICE" | grep -qe "."  # waits for any event
    turn_on
    start_timer
done
```

To start it automatically, I installed Termux:Boot from F-droid, opened it once to allow autostart, and created and `chmod +x`-ed the file `.termux/boot/main.sh` (the file name could by anything):

```bash
#!/data/data/com.termux/files/usr/bin/sh

termux-wake-lock

sudo bash /data/data/com.termux/files/home/brightness.sh &
```

(I also made sure to have sudo installed in Termux, and to have granted it superuser rights.) 

Now, around a minute after every boot, the daemon starts automatically and handles the keyboard brightness wonderfully, without any battery hogging sleep loops.

## Rooting

I mainly followed this [tutorial](https://xdaforums.com/t/tut-root-how-to-root-cat-s22-flip-on-version-30.4626971/), and (to disable root in system.img which conflicts with boot root (magisk)), I pushed the bvN image instead of bvS, since patching the bvS image instead with sas creator will not work as you'll end up with a file that's far too large to flash (more than 2 gigs larger than the original).


## Conclusion

So that's it ! With this device, I can finally be sure that I have an internet access when I need it and I won't have battery life surprises like with my old phone. Having separate devices also adds the question time of "do I really need this ?" when I reach to the bottom of my bag for the other phone.
