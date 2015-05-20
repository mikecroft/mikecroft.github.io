---
layout: post
title: AJP or HTTP?

---

A few days ago, I got called out on a mistake on one of my blogs. The most surprising thing for me, really, is that it's taken this long for me to make a mistake like that! In a nutshell, I wrote [a blog about creating a simple cluster with GlassFish](http://blog.c2b2.co.uk/2013/03/creating-simple-cluster-with-glassfish.html) in which I created a new network listener and enabled it as a jk-listener, even though I was using HTTP to communicate between Apache and GlassFish.

It's not wrong, and it won't break anything, it's not at all necessary.

While I was busily trying to save face over my terrible proofreading, I mentioned that AJP is my preferred option for this kind of scenario anyway. Since I was asked, here's a quick summary of why I generally choose AJP over HTTP between a loadbalancer and a cluster (or single app server, for that matter).

# It's faster



http://en.wikipedia.org/wiki/List_of_HTTP_header_fields

https://tomcat.apache.org/connectors-doc/ajp/ajpv13a.htm

