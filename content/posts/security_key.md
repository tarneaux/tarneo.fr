---
title: "On security keys"
date: 2024-04-21
summary: "My review of the Yubico Security key, and the general support for security keys."
---

A few days ago I purchased a security key from Yubico.

## General review

The security key seems solid. My only complaint is how the capacitive touch button is placed in an indent, causing your fingerprints to only appear on the middle and not the outer part of the circle, which highlights how much of a fingerprint magnet it is.

I chose to buy a simple security key and not a Yubikey because I didn't feel like I needed to store PGP keys this securely; my PGP keys are only used for signing Git commits and the occasional email. I don't think that's worth paying 30 extra bucks.

## Compatibility with various web services

The first thing that struck me was how bad GitHub security key support is: while you can use your security key as a second factor, you have to keep your TOTP app as another possible two factor, which means it's actually _less_ secure than with TOTP only. Passkeys (aka passwordless) are done well with GitHub though, with mandatory PIN entry. Because passkeys act as a password replacement, you could also disable the TOTP app (but this wouldn't count as 2FA, so if you are part of an organization that requires it, you won't be able to).

BitWarden does it all right, it allows using _only_ the security key as a second factor, without the option to use a TOTP token instead (which is, of course, still possible if you enable it). Using the key as a passkey works too, but is useless since you still need to decrypt your vault with your master password. Apparently some keys support storing a decryption token too.

OVH does things well too, allowing you to use only the security key as a second factor.

Nextcloud is the worst: when I added the security key to my account, it just used the security key like a passkey (that is, without asking for the password), but didn't even ask for the PIN! That means anybody in possession of your security key can access your account (if they know your server address and username).

Mastodon doesn't even have any security key related feature, but I guess it's OK since Mastodon accounts are very low profile targets.

## Qutebrowser

With [Qutebrowser](https://www.qutebrowser.org/), the security key works as long as there is no PIN entry needed (which means you can't use a security as a passkey). Since I would not use a single factor, it's alright for me. Note that Qutebrowser doesn't even display a dialog telling you to plug in and tap your key, which means you have to guess when you have to.

This lack of PIN entry implementation is due to the underlying QtWebEngine:

> There's nothing qutebrowser can do here before there's an API from QtWebEngine. At the moment, even normal U2F seems to work for some people but not others, see #3043 and [QTBUG-54720] FIDO U2F support - Qt Bug Tracker - given that the latter is closed for Qt 5.15.1, you might want to report this as a feature request to QtWebEngine instead.[^1]
>
> <cite>Florian Bruhin</cite>

[^1]: https://github.com/qutebrowser/qutebrowser/issues/6131

## Degoogled Android

On my LineageOS phone, I had to install MicroG GmsCore, since AOSP doesn't have support for FIDO without Google Play services.

I had some trouble making it work, and here's what I've learned:

- MicroG _only_ does its magic when you have ticked all the boxes in their settings app's self-check section. At first, I also didn't guess that I could tap the checkboxes to give the permissions and download the other needed app.
- Patched builds of Firefox on Android (like Iceraven) apparently don't come with FIDO/Webauthn capabilities, and I had to install stock Firefox for 2FA to work. This isn't true for desktop Firefox derivatives, Librewolf works with TOTP.

On Android, you also can't use your key as a passkey since PIN entry is not implemented, whether that be with Google Play services or with MicroG.

## SSH

SSH has native support for 2FA with FIDO, and I could set it up without issues on my servers and Git hosts (GitHub, Gitea).

There are two ways of using SSH with FIDO, and they determine whether or not the key can be restored just by knowing the key's PIN. I chose this approach since there is a limit of eight failed PIN attempts and because, according to the [gentoo wiki page](https://wiki.gentoo.org/wiki/YubiKey/SSH), it is more secure.

### Remote privilege escalation with ssh-agent

I tried using [pam_ssh_agent_auth](https://github.com/jbeverly/pam_ssh_agent_auth) to replace `sudo` password verification with tapping the security key, but apparently `ssh-agent` won't allow using the key with FIDO verification for that.
