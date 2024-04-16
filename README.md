# tarneo.fr

This is the source code for my blog. You can see it live at [tarneo.fr](https://tarneo.fr).

My way of deploying this site is to use rsync, see the [Makefile](Makefile) for more details.

## Hook configuration

To allow for automatic checking of e.g. newly created post dates, the `.githooks/` directory should be used by Git. Run:

```sh
git config --local core.hooksPath .githooks/
```

## License

All articles on this website are licensed under the [Creative Commons Attribution-ShareAlike 4.0 International License (CC-BY-SA)](https://creativecommons.org/licenses/by-sa/4.0/).

The code (HTML & CSS) is licensed under the [GNU General Public License v2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html).
