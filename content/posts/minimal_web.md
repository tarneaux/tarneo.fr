---
title: "bringing back the minimal web"
date: 2023-05-08T11:07:41+02:00
summary: "A call to action to bring back the minimal web and how we can achieve it"
---

The internet, once a space of endless possibility and discovery, has become increasingly dominated by a few massive platforms, making it difficult to find smaller, personal and more authentic websites. This shift has led to a homogenization of the web, with many unique and interesting sites being buried beneath the overwhelming weight of larger, more profit-driven platforms.

In this article, we'll explore ways to bring back the minimal web, including the development of a new search engine that would prioritize minimal sites over larger ones, and the promotion of a federated system that allows instances to communicate with one another.

We'll delve into the specifics of how this search engine would work, including its scoring system used for page ranking. We'll also discuss how a lightweight search query and data storage system could help keep the search engine efficient and prevent duplication of content across servers.

# What is the problem?

I'm sure you're familiar with this problem: you search for something on the web, and you end up on those terrible, search engine optimized sites that are just stuffed with a bunch of keywords, ads, and other kinds of bloat, and most of the time you can't even find the solution to the problem. In the search results given by the search engine, most are just done for making money, and just a few are actually written by humans who want to help people out.

My current way of dealing with this is to add "-site:reddit.com" to my search query to sometimes get a good answer to my question. But that is not at all a good solution, because even if you do get an answer, it will often be bad and written in less than a minute by some random redditor.

Search engine [Wiby](https://wiby.me) aims to fix this, but it falls at the other end of the spectrum: there are so few sites indexed there that most searches yield less than 10 results. This is because Wiby is a curated search engine based on user submission that doesn't even crawl the internet.

The internet I want to bring back is made of personal user sites, blogs, wikis, and other kinds of sites that are actually here to help you (or just published by the author for him/herself). Those sites often are tiny, don't use a lot of bandwidth: they are minimal.

We need to bring back the minimal web.

# How can we achieve this?

The first thing we need is an easy way for people to host their own sites or blogs. One way to do this is to use the [tildeverse](https://tildeverse.org) (check out the [indieweb](https://indieweb.org/Getting_Started) too), which is a network of servers that host user sites for free, and started with exactly this goal in mind: bring back personal and minimal websites. There are of course other ways of hosting websites, and we should tell everyone to get one, but this is beyond the scope of this article.

The second thing we need is a way to find those sites. We need to make a search engine with the same idea as Wiby, but that doesn't need user submissions to work: it should crawl the web and index sites automatically. It should be free and open source, and everyone should be able to host their own instance of it. Of course, it should also be possible to submit sites, without it being mandatory for finding results.

The main feature that should distinguish this from other search engines should be some way to prioritize more minimal sites over big ones.

Let's see how we can do this.

## The base for the search engine

This search engine should be federated to allow instances to communicate with one another. Here we can absolutely learn from google's way of doing things: each search query should be sent to all instances, and each instance should return a list of the best results. Then, the user should be able to use the search engine in the way they want: terminal, web, etc. Safeguards should be added in the server software to prevent spamming (duh).

Now, let's talk about how to find and sort the results.

## The result score

Each web page should have a score, determined by the search engine, that will be used to sort the results and know which pages to crawl first (a page with a better score will have its linked pages crawled before another worse page). This score should be based on the following criteria:
- Penalizing factors:
    - The size of the page (in bytes)
    - The number of external resources (images, scripts, etc.)
- Bonus factors:
    - ~~The number of links to the page/site~~: this is a bad idea, because big sites will have more links to them, and thus will be prioritized over smaller sites. We don't want another google.
    - The fact that it is a personal site: this would make it so that personal sites are prioritized over big sites, which is exactly what we want.

The score should be calculated by servers when crawling pages, and should be stored in a public database with all the parts of the score (size, number of external resources, etc.) so that it can be recalculated very fast when a client asks for it. We want this because clients should be able to specify the weights of these parameters, and maybe even add "modules" that would need to be added on the server too.

## The search query

We then need to know how we could search for things in our now big database of pages. For the sake of it being lightweight, we would only store page keywords when crawling, and not the whole page (also removing all HTML tags). This would have the downside of not being able to see cached websites.

Servers should also have a limit of stored data and query each other regularly to prevent having the same site stored too many times. Querying each other could also be used to know which sites couldn't be crawled by other servers (because of the data limit), and so sharing the work efficiently.

# Conclusion

Creating this kind of search engine would greatly improve the state of the web. If you are ready to help this project, I will be happy to add ways to contact you or to see the project at the bottom of this article, and if you have any ideas, please email me too at [tarneo@renn.es](mailto:tarneo@renn.es).


(This article was first edited on may 9th, 2023)
