---
layout: post
title: AJP or HTTP?

---

A while ago, [I got called out on a mistake on one of my blogs](https://twitter.com/philipdurbin/status/597857767316189184). The most surprising thing for me, really, is that it's taken this long for me to make a mistake like that! In a nutshell, I wrote [a blog about creating a simple cluster with GlassFish](http://blog.c2b2.co.uk/2013/03/creating-simple-cluster-with-glassfish.html) in which I created a new network listener and enabled it as a jk-listener, even though I was using HTTP to communicate between Apache and GlassFish.

It's not wrong, and it won't break anything, it's not at all necessary.

While I was busily trying to save face over my terrible proofreading, I mentioned that AJP is my preferred option for this kind of scenario anyway. Since I was asked, here's a quick summary of why I generally choose AJP over HTTP between a loadbalancer and a cluster (or single app server, for that matter).

# It's faster
AJP is a binary protocol, as opposed to HTTP which is text. Each packet is a maximum of 8K and uses only a very small amount of that 8K for headers - just 3 bytes, where byte 3 is the data length of the packet. In comparison, the equivalent HTTP header might be something like `Content-Length: 256`, where each ASCII character would need a byte each.


// The below is for Tomcat, not GlassFish. Needs to be rewritten.
# Connections aren't multiplexed
This is a somewhat subtle difference. Both the AJP and HTTP connector

> Once a connection is assigned to a particular request, it will not be used for any others until the request-handling cycle has terminated.




`http://en.wikipedia.org/wiki/List_of_HTTP_header_fields`

`https://tomcat.apache.org/connectors-doc/ajp/ajpv13a.html`

