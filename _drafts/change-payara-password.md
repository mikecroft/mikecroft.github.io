---
layout: post
title: Change The Payara Admin Password Non-Interactively
comments: true
tags: 
  - stackoverflow
  - payara
---

This post is, hopefully, going to be the first in a series of posts summarising some of the StackOverflow answers I've given in the past. I earned my first gold badge on the site this year - the "Unsung Hero" badge. What this effectively means is that I answer a lot of questions correctly and helpfully, but no-one cares.

The question that this post covers is one about [trying to access the admin console of a Payara Server or GlassFish instance DAS which is running in a container](https://stackoverflow.com/questions/42773521/secure-admin-must-be-enabled-to-access-the-das-remotely-acess-glassfish-admin).

## Background
For security reasons, it is not possible to remotely access the Payara Server admin console without "secure admin" being enabled. Essentially meaning that the admin console should **only** be accessible over HTTPS and should **only** be accessible to authenticated users. Somewhat irritatingly, the default admin user (`admin`) does not have a password set by default and one must be set before "secure admin" can be enabled. Setting this password manually is pretty easy - use the `asadmin change-admin-password` subcommand and follow the prompts - but when you're in an environment like Docker, this isn't going to be possible. Why did Sun and Oracle design things this way? Why not have a default password?

The answer is simple. Some years ago, now, I worked as [an independent consultant for c2b2](https://www.c2b2.co.uk/) and came across users of both JBoss and WebLogic who had Internet-facing application servers. For many people, that alone is a security risk, but when you consider that these versions of those servers had well known default admin user/password combinations and could be easily found via Google...you get the idea. [Raspberry Pi noted (and took action against) the problems with default, well-known user/password combinations] as recently as the end of 2016. Defaults can be convenient, but they just aren't worth the risk!

Back to the question. We know how to change the password in an *interactive* way, but there doesn't seem to be any option to the `change-admin-password` command to allow you tell it both the current and the new password all in one line. This is the problem that the user in the question has hit - ***how can the password be changed non-interactively in a Dockerfile?***

## Use the REST API
A relatively little-known feature of both Payara Server and GlassFish, the REST management interface is a really clever bit of engineering. When any new `asadmin` subcommand gets written and added, Payara Server parses it and generates a REST endpoint for it with no extra development effort! Neat!

https://stackoverflow.com/questions/42773521/secure-admin-must-be-enabled-to-access-the-das-remotely-acess-glassfish-admin/42774130#42774130
