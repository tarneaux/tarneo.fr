---
title: "Controlling a SHARP CE-125 thermal printer from 1982 through WiFi"
date: 2023-09-24
summary: ""
---

When I was small, my father gave me a sharp CE-125 pocket computer / thermal
printer combo he bought when he was in high school. The pocket computer was a
great device: it could be programmed in BASIC and this was actually my first
programming experience, before I even discovered
[Scratch](https://scratch.mit.edu). I think there's only a handful of gen Z
programmers who can actually say they "started" with BASIC programming.
Though the best part of this device wasn't BASIC but the thermal printer.

Though there was one problem with the pocket computer: when I got it, the left
side of the liquid crystal screen was already barely readable because it was
getting too old: all pixels were slowly getting closer to black and couldn't be
used anymore. In the end the display just got useless and I was only able to
write and use small (<10 lines) programs just by imagining what the display
would output after each key press. I quickly lost interest into the machine
after that.

A few years later, I stumbled upon it and again thought it would be great if
paired with an arduino. A quick google search brought me to
[a german blog](http://www.cavefischer.at/spc/html/CE-125_Print-to.html)
where the author had described exactly this project.

It actually turned out to be a pain to get running: I don't exactly remember
why, but I couldn't get the program to compile at first and it took me a few
hours of hacking around (especially because I was very bad at C/C++ programming
at the time) to get it working.

I was incredibly happy to get a few lines printed again, but quickly lost
interest in the thing because I couldn't find a good use for it. It also had
other problems ranging from the size of the circuit (which was based on an
arduino MEGA2560) to the impracticality of having to recompile everything each
time I wanted to print something different (even though that was just me not
knowing about USB serial communication).

Fast-forward: around three and a half years after that, I bought a few
[Seeed XIAO](https://wiki.seeedstudio.com/XIAO_ESP32C3_Getting_Started/)'s
for various hardware projects. I had the idea to get the SHARP thermal printer
back out and try making a usable API for it.

Thanks to some better understanding of C/C++ programming and to having learnt
soldering, I was able to make some decent [software]
(https://github.com/tarneaux/sharp-ce-125-esp) and my first handwired
circuit board. Now the whole thing could sit quite nicely in the space that was
previously taken up by the (broken) cassette reader.

![The sharp CE-125 thermal printer with the circuit board in the cassette
reader's cutout](./printer.webp)

I am now able to run a python script which will read text from STDIN and send
it straight to the printer. For now I've already used it to print 2FA recovery
codes, and I'm sure I'll find other neat uses for it as time goes on.

I may even be able to interface directly with the printing head and motor to
make for a smaller footprint through a mix of reverse engineering and reading
the device's service manual, but that's a project for another day.
