---
title: "Qutebrowser is cool"
date: 2023-05-22T21:50:01+02:00
summary: "Yes it is"
---

## Umm... what is Qutebrowser?

Qutebrowser is basically "just" a web browser that has a vim-like interface, plus it's one of the few web browsers that are actually not spyware (yes, there are only a few, see [this](https://spyware.neocities.org/articles/)).

## Why is it so cool?

I quite frequently go looking through random web pages from the indieweb (which I will eventually post a selection of on this blog), and very often find myself in a situation where I want to do something else but not loose my open tabs (even though I write down the nice stuff in an orgmode document). I realized that Qutebrowser had a very simple feature which just seems like the only right way to do this: just hit `:w cool-stuff` and then I can see it again whenever I want by just running `:session-load cool-stuff`. I guess the time of having 1000 open tabs at once is over now :-)

Qutebrowser also has another really cool feature which is hinting. Just press `f` while in normal mode, and letter combinations will show up on every link of the page. The nice thing is you can also configure which keys it uses (by default it's the QWERTY home row). I just changed it to "arstneio", which are exactly at the same positions on my keyboard layout (Colemak) which I use on my [monkeyboard](/posts/split_keyboard).

Speaking of Colemak, vim-like software is often quite hard to use with it (because of the different home row keys), but like with most of these, I was able to just add the shortcuts for hjkl to my arrow keys (which are on the homerow). This way I don't have to map hjkl original actions of neio (= doing a keybinding swap), which I already did on my tmux config: I wanted to use C and G for splitting, but had to do a keybinding swap there too because C is used for creating a new window. For tmux this is okay because I split much more often than I make a new window, plus they are not very logical in their original placement (really, what is C supposed to stand for? Create?).
