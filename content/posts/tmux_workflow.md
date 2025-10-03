---
title: "My tmux workflow"
date: 2025-10-03
summary: "And my window switcher menu"
---

My Tmux workflow is very close to my awesomewm one.

## Window switching

The first similarity is in window switching, which matches my tag keys on awesomewm, only with the different Alt modifier. a, r, s, t, d, h are the six first keys on the colemak home row, which my [keyboard](../triboard/) uses.

```sh
# Window switching (by index)
set -g base-index 1
bind -n M-a selectw -t 1
bind -n M-r selectw -t 2
bind -n M-s selectw -t 3
bind -n M-t selectw -t 4
bind -n M-d selectw -t 5
bind -n M-h selectw -t 6
```

## Window management

These are usually done by hitting the Tmux prefix and then another key. I remapped them to direct binds with Alt, like most of my bindings.

```sh
# creating windows and panes
bind -n M-x split-window -h
bind -n M-c split-window -v
bind -n M-b new-window
```

## Scratch windows

To these basic switching shortcuts, I added two scratch windows: a generic one, e.g. for running the project, and one running Lazygit. These are opened in every newly created session.

```sh
# Generic scratch window
set-hook -g session-created[0] 'new-window -d -n scratch -t 100'
bind -n M-p selectw -T -t scratch
# Lazygit scratch window
set-hook -g session-created[1] 'new-window -d -n git -t 101 sh -c "while true; do lazygit; done"'
bind -n M-g selectw -T -t git
```

## Session switching

On to the most useful part of my Tmux config: the `tmw` and `tms` scripts, which are fzf based window switchers, one local and the other for servers.

`tmw` can be triggered from tmux inside a popup, but it can be run directly since fzf can automatically open a custom popup thanks to the `--tmux` option.

```sh
# popups
bind -n M-w run-shell "tmw >/dev/null || true" 
```

But it can also be used from outside with its command. It will automatically decide whether it needs to switch to a session or open tmux in said session.

`tmw` supports creating sessions in a directory by querying `zoxide` for short directory names. So if I want to open a session for my Nix repo, I'll type `tmw nix` or `tmw` and type `nix`.

When a `tmw` or `tms` query string matches a session that isn't the wanted one, a `+` can be added to the query to prevent matches, and it will be removed before doing anything else, allowing to force creation of new windows.

`tms` simply asks for a hostname and `ssh`-es to it through my [wireguard tunnel](../wireguard_namespace/).

[Here's a link to tmw](https://git.sr.ht/~tarneo/nix/tree/main/item/hm/tmux/tmw.sh). It is recommended to set good shell options (something like `set -euo pipefail`) in it, I do it with Nix.

The main trick `tmw` has up its sleeve is using fzf with `-0` (which exits if there are no matches) and `-1` (which exits immediately when there is a single match). `-1` is set only if we have a pre-set query, otherwise having a single session would always open it immediately, preventing the creation of new ones.

## Git link

Like all others, my Tmux config can be found in [my nix config repo](https://git.sr.ht/~tarneo/nix/tree/main/item/hm/tmux).
