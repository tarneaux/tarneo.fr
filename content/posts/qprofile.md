---
title: "Adding isolated profiles to Qutebrowser"
date: 2025-10-03
summary: ""
---

One very useful feature that is "missing" from stock Qutebrowser is isolated browser profiles, a.k.a sessions. These allow full isolation of user data, be it history, cookies, bookmarks...

I've written a simple script, `qprofile`, which solves this problem by having multiple Qutebrowser base directories and choosing between them with a `dmenu` script, including when opening links with `xdg-open`.

## The base script

This one handles linking the common configs and Greasemonkey directories so that the experience is cohesive enough. It also allows creating temporary profiles which will be deleted on close (kind of like private browsing, except I wouldn't use it for anything really private).

As always, this script is available [in my dotfiles](https://git.sr.ht/~tarneo/nix/tree/main/item/hm/qutebrowser/qprofile.sh).

```sh
#!/usr/bin/env bash

CREATE="no"

while [[ $# -gt 0 ]]; do
    case $1 in
    -c | --create)
        CREATE=YES
        shift
        ;;
    *)
        PROFILE=("$1") # save positional arg
        shift          # past argument
        break
        ;;
    esac
done

if ! [ "${PROFILE+set}" ]; then
    echo "Missing profile name."
    exit 1
fi

if [[ $PROFILE == "tmp" ]]; then
    BDIR="$(mktemp -d)"
else
    BDIR=~/.config/qb-profiles/"$PROFILE"
fi

if [[ $PROFILE == "tmp" ]] || [[ $CREATE == "YES" ]]; then
    mkdir -p "$BDIR"/config/
    mkdir -p "$BDIR"/data/
fi

ln -sf ~/.config/qutebrowser/config.py "$BDIR"/config/config.py
ln -sf ~/.config/qutebrowser/autoconfig.yml "$BDIR"/config/autoconfig.yml
ln -sf ~/.config/qutebrowser/greasemonkey "$BDIR"/config/
ln -sf ~/.local/share/qutebrowser/blocked-hosts "$BDIR"/data/blocked-hosts
ln -sf ~/.local/share/qutebrowser/adblock-cache.dat "$BDIR"/data/adblock-cache.dat

if [[ ! -d $BDIR ]]; then
    echo "Base directory not found, specify --create to create it"
    exit 1
fi

qutebrowser --basedir "$BDIR" "$@"

if [[ $PROFILE == "tmp" ]]; then
    rm -rf "$BDIR"
fi
```

## The menu

This is a simple one-liner that lists profiles and shows a menu. You could substitute `rofi` for any other picker you like.

```sh
cat \
  <(find ~/.config/qb-profiles/ -mindepth 1 -maxdepth 1 -type d -printf '%P\n') \
  <(echo tmp) |
  rofi -dmenu -p profile |
  xargs -r -I '{}' qprofile '{}' "$@"
```

I wrote it into a `qprofile-menu` script, which can then be called by a shortcut.

## XDG config

To open links with the menu instead of the base profile, we'll create a desktop entry and set it as the default handler for a few MIME types.

This is the config for Home Manager in Nix. It should be quite easy to translate it to a `.desktop` file.

```nix
xdg.desktopEntries.qprofile = {
  name = "Qutebrowser Profile";
  genericName = "Web Browser";
  exec = "qprofile-menu %U";
  terminal = false;
  categories = [
    "Network"
    "WebBrowser"
  ];
  mimeType = [
    "text/html"
    "text/xml"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
    "x-scheme-handler/qute"
    "x-scheme-handler/about"
  ];
};
xdg.mimeApps.defaultApplications = {
  "text/html" = [ "qprofile.desktop" ];
  "x-scheme-handler/http" = [ "qprofile.desktop" ];
  "x-scheme-handler/https" = [ "qprofile.desktop" ];
  "x-scheme-handler/about" = [ "qprofile.desktop" ];
  "x-scheme-handler/qute" = [ "qprofile.desktop" ];
};
```

