+++
title = "About me (tarneo)"
date = 2023-03-25
+++

# whoami

I started programming with MIT's [Scratch](https://scratch.mit.edu) in primary school at the age of 9. Two years later I switched to Python, which was my go-to programming language for a few years. I then started using other languages: HTML and CSS, Arduino C, C itself, Javascript, and Go. I write configuration files in Lua wherever I can (NeoVim, AwesomeWM), and I do my scripting with Bash. I now use Rust for more complicated projects, mainly because of its great developer experience.

I am the administrator of [Renn.es](https://renn.es) and every service there runs inside a Docker container.

I am in high school in Paris and make little projects that, most of the time, are just for my personal use.

Most of my projects are on [my github](https://github.com/tarneaux) and/or on the [renn.es git server](https://git.renn.es/). One I really enjoyed making is my split keyboard, the [monkeyboard](/posts/split_keyboard).

> "I use arch BTW"

I use Arch Linux as my daily driver and I don't plan to go back to windows anytime soon. I just think Free Software is the only way to get good programs that are designed for the best user experience instead of just making money. I managed to get rid of most of the proprietary software I once used: I will never regret doing that and I do think you should too.

I think one could sum up my thoughts on proprietary software with this quote from John Maynard Keynes:

> "Capitalism is the extraordinary belief that the nastiest of men for the nastiest of motives will somehow work together for the benefit of all."
>
> <cite>John Maynard Keynes</cite>

I also like to use programs which adhere to the Unix philosophy, namely: do one thing and do it well. This is why I do not use things like Nextcloud or an office suite.

I believe everyone should have the right to not be tracked or have their data sold to third parties without their ACTUAL consent (which I'd hope nobody would be dumb enough to give). If you think "I have nothing to hide", check out Glenn Greenwald's Ted Talk ["Why Privacy Matters"](https://yewtu.be/watch?v=pcSlowAhvUk). For this matter I also recommend you read [the Wikipedia article about mass surveillance](https://en.wikipedia.org/wiki/Mass_surveillance).

I don't like most of "social" media platforms: Instagram or TikTok, in my very humble opinion, do not provide any value to the user. I am also not a user of any google service apart from YouTube, which I always access through NewPipe or mpv(1).

## Software I use

- Editor: [Neovim](https://neovim.io/) for everything: code, text, this website, and so on. I even make presentations in Markdown and convert them to HTML using [Marp](https://marp.app/).
- Web browser: [Qutebrowser](https://qutebrowser.org/), mainly because of its Vim like keybindings. It is also one of the only web browsers that don't contain trackers: even those that claim they want to "protect your privacy" have them: [Firefox](https://digdeeper.neocities.org/articles/mozilla), [Brave](https://spyware.neocities.org/articles/brave), [Opera](https://spyware.neocities.org/articles/opera) (if you use Opera, please stop). If you want a REAL privacy browser, use LibreWolf or ungoogled chromium with some [privacy addons](https://digdeeper.neocities.org/articles/addons). Do note that they are still not perfect, see [here](https://spyware.neocities.org/articles/). Qutebrowser doesn't block Youtube ads very well, which leads us onto the next point:
- Youtube players: mpv + youtube-dl for PC and [NewPipe](https://github.com/TeamNewPipe/NewPipe) for Android. You might also want to consider Invidious.
- Mobile web browser: [Iceraven](https://github.com/fork-maintainers/iceraven-browser). This is the best browser for android because it is the only one that is decent. Its features include:
    - It is a fork of a real browser (firefox) and so most sites will work with it.
    - It ACTUALLY doesn't track you, at least according to my research.
    - It supports extensions. Big plus because that way I can use uMatrix for blocking scripts and other nasty stuff.
    - Bottom address bar that does not require you to awkwardly stretch your thumb to the top! yaaay!
- Search engine: [SearXNG](https://docs.searxng.org/) ([find an instance](https://searx.space/)). This is the best meta search engine[^1] I could find. I enabled Google, Duckduckgo, Qwant and [Wiby](https://wiby.me/)[^2].
- Terminal emulator: [Alacritty](https://github.com/alacritty/alacritty). I find it better than [Kitty](https://sw.kovidgoyal.net/kitty/) (even though Kitty has ligatures support) because it isn't spyware by default (most Linux distros have kitty packaged with telemetry disabled though).
- Linux distribution: Arch Linux, as already explained above. I won't say it is the best because it's not for everyone: you need some serious command-line knowledge to get it working. But once that's done you will have a fantastic package manager along with the number of packages in the AUR. For non tech savvy people I have always recommended Fedora's KDE spin. I am also not blue-pilled enough to accept using Microsoft Windows anywhere.
- File syncing, along with anything that runs on servers: see information at [Renn.es](https://renn.es/).
- Password manager: Bitwarden because I tend to loose my files. If that wasn't the case I would use GNU Pass or KeepassXC.
- Phone OS: [LineageOS](https://lineageos.org/) to escape all of that Google crap.
- Email client: [aerc](https://aerc-mail.org/) for PC and [FairEmail](https://email.faircode.eu/) for Android.

For a few of those pieces of software, you can find my config files [here](https://git.renn.es/.f-tarneo).

[^1]: a meta search engine takes results from others and makes a single result page.
[^2]: Wiby is a search engine for the minimal web. Unfortunately it is curated, which limits the number of results a lot, but this still allows me to find random blogs and sites when looking for things. Usually it shows me a second result that has nothing to do with my search query, but sometimes it's actually interesting.


## License

All articles on this website are licensed under the [Creative Commons Attribution-ShareAlike 4.0 International License (CC-BY-SA)](https://creativecommons.org/licenses/by-sa/4.0/).

The code (HTML & CSS) is licensed under the [GNU General Public License v2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html).
