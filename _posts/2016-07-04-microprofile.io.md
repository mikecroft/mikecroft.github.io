---
layout: post
title: microprofile.io
comments: true
---


Last week, on Monday 27th June, Red Hat's DevNation began. I was privileged enough to be on stage during the Keynote, joining Tomitribe's Theresa Nguyen, IBM's Alasdair Nottingham, the London Java Community's Martijn Verburg and Red Hat's Mark Little, as we announced a joint venture in [MicroProfile.io](http://microprofile.io/).

Plenty of other people have written about what it is already, so I won't dwell on that too much; suffice it to say that a version 1 release is targeted for September from all vendors and is currently slated to include the most minimal set of specs possible:

 * CDI
 * JAX-RS
 * JSON-P

It is somewhat likely that Servlets will come along with that since it's pretty tightly coupled to JAX-RS and it may be exposed by one or two implementations. I haven't read any final consensus on that in [the Google Group](https://groups.google.com/forum/#!forum/microprofile). Some early suggestions for a future version 2 release (discussions are slated to begin in October) are Bean Validation, Concurrency and Security. As many of the more prominent group members have made clear - **all** contributions are welcome. Any question, suggestion or even criticism is always welcome.

# The Great Leveller
A really key aim of the initiative - one that is (in my mind) the most attractive - is ***open collaboration***; About the biggest strength of Java as a language, even aside from the Java EE framework, is its openness.

I love the fact that British people are known for drinking tea because of the accessibility of it and broad acceptance of it in all social circles:

> *"Aristocrats, and the royal family, drink tea; working-class people drink tea...it's a great symbol of social levelling"*  
> *[The Guardian](https://www.theguardian.com/news/2005/jan/26/food.britishidentity)*

This is how I've always seen Java. Being founded on open source with an open standards body has meant that not only is Java trusted worldwide by such technical "aristocrats" as financial institutions, it's also the first programming language I was taught at University and a language traditionally used by people who could not afford Windows licenses for the .NET Framework. (*Though this may change with Microsoft's recent push towards openness*)

# A Move Towards Standards
As Mark Little [recently clarified on his blog](https://developer.jboss.org/blogs/mark.little/2016/07/04/the-microprofile), the MicroProfile is **not** a standard. It is, however, beginning with every intention of becoming a standard. Competitors or alternatives to Java EE have always been backed by a single vendor, whether Microsoft's .NET, Spring's popular framework, Grails or the Play Framework. This may work for a lot of people but, as anyone who has been in tech for any reasonable amount of time will know, nothing is forever. Just within Java we have seen vendors come and go, including Sun itself.

A considerable number of larger users of Java EE choose it due to the incredible weight of support of multiple large companies and a hugely passionate community. A big advantage of standards is the reassurance that the standard can always be carried on easily and a lot of reassurance can be drawn from that.

It remains to be seen exactly how the MicroProfile will evolve, but I am very optimistic about it. Not just because I'm personally involved with it, but because the entire community is.
