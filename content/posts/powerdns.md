---
title: "Setting up a self-hosted authoritative DNS server with PowerDNS"
date: 2023-11-20
summary: ""
---

I have been using Cloudflare for over a year now for multiple domain names. I wanted to migrate away from that, and chose to self-host DNS using [PowerDNS](https://www.powerdns.com/).

PowerDNS provides multiple types DNS servers, but what you'll want to host our own domain is an authoritative name server. This will publish the DNS records for our domain so that recursive name servers (like Google's, Cloudflare's or your ISP's) can forward the data to clients.

## Prerequisites

Most registrars will require you to have two different name servers, which is a good practice (I chose OVH as my registrar but anything should work with this tutorial).

Ideally you want to have your two DNS servers at two different locations to provide enough redundancy. I chose to have one server on a VPS and another at home on the main [Renn.es](https://renn.es) server. Make sure your ISP allows opening port 53 and requests come through correctly though, as most don't.

## Compose example

Here is a `docker-compose` example:
```yaml
services:
  pdns:
    container_name: pdns
    image: powerdns/pdns-auth-master:48-lmdb-index-1
    ports:
      - "53:53"
      - "53:53/udp"
    volumes:
      - "/data/pdns/varlib:/var/lib/powerdns"
      - "/data/pdns/etc:/etc/powerdns"
```

You should of course change `/data/pdns` to wherever you want to host your PowerDNS related files.

Run `docker-compose up -d` once before proceeding to create the volume directories. It will probably just fail to start because of a missing database file.

## Creating the database

Download the database schema from [GitHub](https://github.com/PowerDNS/pdns/blob/master/modules/gsqlite3backend/schema.sqlite3.sql).

Then run:
```sh
sudo sqlite3 /data/pdns/varlib/pdns.sqlite3 < schema.sqlite3.sql
```

I had a permission issue when trying to run the container again, so I ran a `sudo chown -R 953:953 /data/pdns`. Make sure there is no UID or GID 953 on your system because that user would have access to `/data/pdns`.

Then run `docker-compose up -d` again. The container's log should end with the following line:
```
Done launching threads, ready to distribute questions
```

## Editing zones

There are many frontends for PowerDNS, but I chose to not install any and use the included [pdnsutil](https://doc.powerdns.com/authoritative/manpages/pdnsutil.1.html) command-line utility for simplicity.

Create an empty zone for your domain name (I'll use `charennes.org` from now on as an example):
```sh
docker exec -it pdns pdnsutil create-zone charennes.org
```

Edit the zone (I hope you're familiar with `vi`):
```sh
docker exec -it pdns pdnsutil edit-zone charennes.org
```

I first changed the default [SOA record](https://en.wikipedia.org/wiki/SOA_record) to match the configuration I wanted:
```dns
charennes.org   3600    IN      SOA     ns.charennes.org admin.charennes.org 0 10800 3600 604800 3600
```

This tells DNS that the name of the main DNS server for your zone is `ns.yourdomain.org` (`ns.charennes.org` in my case). You should also add an email address with the `@` replaced by a dot. If there are dots in your email address (before the `@`), use a backslash to escape them.

So let's create an A record for `ns.charennes.org`:
```dns
ns.charennes.org        3600    IN      A       82.64.143.64
```
Of course you should replace the IP to match your public IP.

Let's also add our VPS's public IP, which will be used as a backup:
```dns
ns2.charennes.org       3600    IN      A       51.210.180.14
```

We can then add two NS records to point to the DNS servers we just defined:
```dns
charennes.org   3600    IN      NS      ns.charennes.org
charennes.org   3600    IN      NS      ns2.charennes.org
```

I also added the following to set the IPv4 address of `charennes.org`:
```dns
charennes.org   3600    IN      A       82.64.143.64
```

Here's the final file:
```dns
; Warning - every name in this file is ABSOLUTE!
$ORIGIN .
charennes.org   3600    IN      SOA     ns.charennes.org admin.charennes.org 0 10800 3600 604800 3600
charennes.org   3600    IN      A       82.64.143.64
charennes.org   3600    IN      NS      ns.charennes.org
charennes.org   3600    IN      NS      ns2.charennes.org
ns.charennes.org        3600    IN      A       82.64.143.64
ns2.charennes.org       3600    IN      A       51.210.180.14
```

Now I was able to test the server with the following command:

```sh
nslookup charennes.org <server-ip>
```
```
...
Address: 82.64.143.64
...
```

Remember to open port 53 (for both TCP and UDP) and check that queries also work from outside your firewall!

I also ran the following command to enable DNSSEC:
```sh
docker exec -it pdns pdnsutil secure-zone charennes.org
```

Note that you will have to find a way to sync the server's database between your two servers. I chose to use a one-way rsync script which I run every time I update stuff. Remember to restart the docker container whenever you overwrite the database because it won't reread it by itself. Also know that overwriting databases is not the best practice in most cases, but I think it's OK here since the database isn't being written to without modifying domains.

## Letting DNS know about our new server

Now you'll need to tell your registrar about the server you just created. This is a bit tricky as you need to give the registrar the domain names of your servers, but they don't have one yet as the DNS isn't propagated. What I did was add A records for `ns.charennes.org` and `ns2.charennes.org` matching the ones I had defined on my own name server, and then set the DNS servers to those which worked alright. It took some time though, around an hour to get to my own PC, but it could be up to two days until every computer on the internet has the new correct records (due to cache time to live).
