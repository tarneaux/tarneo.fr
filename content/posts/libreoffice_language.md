---
title: "Getting LibreOffice to work with French on Fedora Linux"
date: 2023-06-20T19:54:45+02:00
summary: "It's easy but hard to find"
---

Today I had to setup LibreOffice on Fedora with French support and really wished there was a tutorial for it.

This is what this post is, and it should work with any language.

## Spellcheck language

- Install the hunspell package for your language. Example for French:
```bash
sudo dnf install hunspell-fr
```
- Restart LibreOffice for it to notice the changes .
- Head over to `Tools > spellcheck...`. Your language should now appear there.

## GUI language

- In the same way, install the LibreOffice language pack for your language. Example for French:
```bash
sudo dnf install libreoffice-langpack-fr
```
- Restart libreoffice for it to notice the changes.
- Now the GUI follows the system language. If not you may need to find the setting yourself.

## Conclusion

It's that easy, but it took me some chance and time to find it.
