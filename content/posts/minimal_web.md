---
title: "bringing back the minimal web"
date: 2023-05-08T11:07:41+02:00
summary: "A call to action to bring back the minimal web and how we can achieve it"
---

The internet, once a space of endless possibility and discovery, has become increasingly dominated by a few massive platforms, making it difficult to find smaller, personal and more authentic websites. This shift has led to a homogenization of the web, with many unique and interesting sites being buried beneath the overwhelming weight of larger, more profit-driven platforms.

In this article, we'll explore ways to bring back that version of the web, including the development of a new, federated search engine that would prioritize minimal sites over larger ones.

We'll delve into the specifics of how this search engine would work, including its scoring system used for page ranking and methods to prevent duplication of data across servers.

## What's the problem?

I'm sure you're familiar with this problem: you search for something on the web, and you end up on those terrible, search engine optimized sites that are just stuffed with a bunch of keywords, ads, and other kinds of bloat, and most of the time you can't even find the solution to the problem. In the search results given by the search engine, most were just written by AI's to make money, and just a few are actually handcrafted by humans who want to help people out.

My current way of dealing with this is to add "-site:reddit.com" to my search query to sometimes get a good answer to my question. But that is not at all a good solution, because even if you do get an answer, you are still using one of the tech giant's sites.

Search engine [Wiby](https://wiby.me) aims to fix this, but it falls at the other end of the spectrum: there are so few sites indexed there that most searches yield less than 10 results. This is because Wiby is a curated search engine based on user submission that doesn't even crawl the internet.

I want to bring back personal sites, blogs, wikis, and other kinds of sites that are actually here to help you (or just published by the author for him/herself). Those sites often are tiny and don't use a lot of bandwidth: they are minimal. In my opinion, sites like this are just better, and I'm certainly not the only one.

In the modern internet, there is no good way of finding those more minimal sites, and that is what I want to fix. You don't have to agree with me: if you like big bloated sites, I'm fine with that. I just want the freedom to use a search engine that does not rank sites like WikiHow right on top.

We need to bring back the minimal web.

## How can we achieve this?

There are two things we need to do to bring back the minimal web:
- Make it easy for people to host their own sites
- Make it easy for people to find those sites

### Hosting people's sites

One popular option for people to host their own sites or blogs is by using [Neocities](https://neocities.org/). It is donation-based and provides an easy and user-friendly platform for individuals to create and host their own websites without much technical knowledge.

If you want something more community-oriented, you can explore the [Tildeverse](https://tildeverse.org). It is a collection of personal servers and communities which offer various services such as web hosting, email, IRC, and more. The [IndieWeb](https://indieweb.org/) is also worth a look. 

Another option for more tech-savvy users is to host their sites on a VPS or even their own server, but this means that you will have to maintain it and it may not stay up all the time. Still, this is what I do for this site (see [renn.es](https://renn.es)).

As you can see, hosting minimal websites is not really such a big problem. The problem is finding them.

### Finding people's sites

So, we need a search engine with kind of the same idea as Wiby, but that doesn't need user submissions to work: it should crawl the web and index sites automatically. It should be free and open source, and everyone should be able to host their own instance of it. Of course, it should also be possible to submit sites, without it being mandatory for finding results.

The main feature that should distinguish this from other search engines should be some way to prioritize more minimal sites over big ones.

Let's see how we can do this.

#### The base for the search engine

This search engine should be federated to allow instances to communicate with one another. Here we can absolutely learn from google's way of doing things: each search query should be sent to all instances, and each instance should return a list of the best results. Then, the user should be able to use the search engine in the way they want: terminal, web, etc. Safeguards should be added in the server software to prevent spamming (duh).

Now, let's talk about how to find and sort the results.

#### The result score

Each web page should have a score, determined by the search engine, that will be used to sort the results and know which pages to crawl first (a page with a better score will have its linked pages crawled before another worse page). This score should be based on the following criteria:
- Penalizing factors:
    - The size of the page (in bytes)
    - The number of external resources (images, scripts, etc.)
- Bonus factors:
    - ~~The number of links to the page/site~~: this is a bad idea, because big sites will have more links to them, and thus will be prioritized over smaller sites. We don't want another google. This *may* be used to promote non-minimal sites popular among minimal sites.
    - The fact that it is a personal site: this would make it so that personal sites are prioritized over big sites, which is exactly what we want.

The score should be calculated by servers when crawling pages, and should be stored in a public database with all the parts of the score (size, number of external resources, etc.) so that it can be recalculated very fast when a client asks for it. We want this because clients should be able to specify the weights of these parameters, and maybe even add "modules" which would be a server add-on to add some more filters and the like.

#### The search query

We then need to know how we could search for things in our now big database of pages. For the sake of it being lightweight, we would only store page keywords when crawling, and not the whole page (also removing all HTML tags), so that we don't fill up storage immediately. Remember, it's meant to be hosted by individuals! This would have the downside of not being able to see cached websites.

Servers should also have a limit of storage space and query each other regularly to prevent having the same site stored too many times. Querying each other could also be used to know which sites couldn't be crawled by other servers (because of limited storage space), and so sharing the work efficiently.

#### Additional features

We could also add some features to the search engine to make it more useful:
- A way to give the search engine a site and have it give you a list of similar sites
- Crawling sites on the Web Archive to find sites that are no longer online?
- [anything else?]

## Conclusion

While solutions to host personal sites already exist, there is no good way to find them. Creating this kind of search engine would greatly improve the situation of the web. It would help a bit to bring back and promote that kind of internet where sites are owned by people (which was the internet's initial goal) and not tech giants.

## Notes

- There is a pair of articles on Anil Dash's blog that are worth a read: [The web we lost](https://www.anildash.com/2012/12/13/the_web_we_lost/) and [Rebuilding the web we lost](https://www.anildash.com/2012/12/18/rebuilding_the_web_we_lost/).
