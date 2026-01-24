---
title: "Contact, PGP, Git"
aliases:
  - pgp
---

## Contact

Feel free to contact me through email: tarneo@tarneo.fr

If you send me an email and are familiar with PGP encryption, please use the key below.

## Git accounts

My projects are available on my Sourcehut: [~tarneo](https://git.renn.es/~tarneo/)

I also have a GitHub account, which I will gradually stop using: [tarneaux](https://github.com/tarneaux)

All my commits should be signed with PGP.

## PGP

To download my PGP keys automatically with GnuPG using my WKD:

```sh
gpg --locate-keys tarneo@tarneo.fr
```

Or using a keyserver:

```sh
gpg --recv-keys 4E7072A78326617F A106AD72EA62ADDF
```

You can also [download](/.well-known/openpgpkey/hu/twnxbp33gur4nwext9bzmm6mahjw44hr) the keys and then import them manually.

- The encryption key's fingerprint is `BB7E 3E76 C8DB 37AF 94F3  22DF A106 AD72 EA62 ADDF`.
- The git signing key's fingerprint is `74E9 F0A2 0B52 F743 674B  04A5 4E70 72A7 8326 617F`.
