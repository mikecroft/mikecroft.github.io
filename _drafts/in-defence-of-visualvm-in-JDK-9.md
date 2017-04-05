---
layout: post
title: In Defence of VisualVM In JDK 9

---

For the best part of a decade now, the much loved JDK monitoring tool VisualVM has been included in the download of Oracle JDK. From Java 9, however, [that's going to change](https://blogs.oracle.com/java-platform-group/entry/visual_vm_in_jdk_9).

OK, so I'm a little late to the party with this, and I only found out thanks to [a tweet from David Heffelfinger pointing it out](https://twitter.com/ensode/status/849559586570997760). Although a lot of people will think that this is a fairly minor change, given that VisualVM will still be free, opensource and [available at its new home on GitHub](http://visualvm.github.io). I do think this is a worthwhile thing to take note of, though, since it's indicative of a wider trend in the industry at the moment.

# A Micro Future
At this stage, it's probably completely inappropriate to continue calling microservice architectures "new". They're getting more and more established and I speak to more and more customers who are evaluating modern microservice-style deployment styles, despite their applications needing significant changes to be broken up into discrete services.

At Payara, there are lots of things being added to both Payara Micro and Payara Server to make life easier for running microservices and to adapt to new cloud environments exactly for this reason; we want to give developers the tools they need before they need them so that they can evolve applications incrementally, not as a "big-bang". As I was reminded when I was on site with a customer this week, those days are still a long way off for many customers and there are plenty of problems that need solving today, before we begin trying to solve problems of tomorrow.

So what's all this got to do with VisualVM?

With JDK 9, the name of the game is ***micro***. The biggest feature, making waves for all kinds of reasons, is certainly Jigsaw - the modularisation of the JDK. This will result in a JDK which can be repackaged with only the modules you need for your application. No longer will your application server need to run on a JDK which includes graphics classes! The act of adding a JDK layer to your Alpine Linux-based Docker image will no longer increase the image size from ~5MB to ~120MB!

Surely ditching VisualVM is a logical move with all the other efforts to trim the fat?

Thinking back to times when I've been working with customers, I can think of hundreds of times where VisualVM has been incredibly valuable to the diagnosis of issues in production.

[Devoxx Belgium 2015](https://www.youtube.com/watch?v=9DzzeJyh3H0)
