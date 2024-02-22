---
title: "A review of the Framework laptop 13"
date: 2024-02-22
summary: "It's boringly positive"
---

I've been daily driving the Framework Laptop 13 for more than two months now, this is my review of it.

I've only ever owned second-hand laptops, because I never felt the need to have something better; but this year I started lugging my old dual-core Asus laptop to high school twice a week: it felt suboptimal to say the least: the battery didn't last much more than an hour (despite being only a year old), and I had to carry the (huge) charger and awkwardly find a plug in the classroom. Long story short, I needed a laptop.

I had the choice between:
- buying a 300€ laptop for the nth time, replacing the battery for an additional 50-100, still using a separate desktop computer, and buying a new one in a few years;
- buying a Framework laptop for four times the price of a refurbished laptop, having much better battery life and performance (with the base AMD config: six cores at 4.9Ghz, which actually makes it twice as fast as my server!), stop using a separate desktop computer, possibly keeping it for more than 10 years.

I was unsure but chose the Framework laptop in the end.

## Battery life

I limit my battery charge to 80 percent with the BIOS option in order to improve battery durability. Having that option built into the BIOS is great!

With five Qutebrowser tabs, five tmux sessions and eight neovim instances running, I get about 6 hours of battery life (from 80%). This is plenty for what I do, and I can always plug the laptop in if it's every 6 hours (as opposed to the 1 from my Asus laptop).

## Performance

Here are some of my non-scientific findings when using the laptop:
- Compared to my previous 4-core 8-thread desktop computer, Rust builds are *FAST*. I don't really wait much when iterating, and `cargo check` runs in a tenth of a second after one modification in a small API project.
- I'm currently building a project using OpenCV's image processing. At 10 FPS, it runs a pair of 720p grayscale images through a filter of (in order) `absdiff => gaussian blur (15x15) => thresholding => 15 dilations => contour detection`. My previous computers ran this at 3 FPS max.
- Although I don't game a lot, it is definitely possible on this: at the internal screen's resolution (2K), I can get a steady 60 FPS from Minecraft (with lite to medium shaders, 32 chunks of render distance). For other games you'll have to find the information somewhere else.

## Build quality

The build quality is great. Framework has paid attention to the fine details with this laptop, and the fact that the lower right corner of the keyboard shifts up when untightening the screws is just a hint at how well the laptop is designed.

Here are my only two gripes with it:
- The expansion cards are, like, *hard* to remove. Once you know it works, it can be done without too much hassle though.
- Oh, the second one fixed itself. But until now I would hear a little click when opening the laptop to 180 degrees and folding it back. So problem solved I guess?

## Screen

It has been very annoying to make the laptop work with my LG ultrawide: since the internal screen has almost twice the resolution of the LG (which is 2560x1080 at 34 inches), the font size had to be changed between 9 and 13 pixels.

In the end, I fixed it by having an `autorandr` (the thing that manages my displays on hotplug) post switch hook which would change the font size of Qutebrowser (my web browser) and Alacritty (my terminal emulator) to match the screen's resolution. Other apps like Signal just have the resolution that fits the internal screen and are comically large on the LG one.

## Keyboard

Hey, look, I don't really care about the keyboard since I just lay [another one](/posts/triboard) on top of it. But the keyboard is good too when I have to type on it.

## Fingerprint reader

The fingerprint reader works with `fprintd` out of the box on Linux.

## Repairability

This is the greatest part of the laptop, but it's the thing you want to do as late as possible since it would involve a part breaking...

The only thing I can say for now is I am not as afraid to clean the screen a bit heavily as I was on previous computers, even though it looks much more fragile.

## Conclusion

I don't really know what's not to about this laptop. Everything seems right, and that may be why so many people are buying it ;-).
