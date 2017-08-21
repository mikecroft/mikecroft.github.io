---
layout: default
title: conferences
---


From time to time, I speak at some conferences. It's always an interesting experience because I never know how they are going to go. Some that I think have been rubbish get a great reception, then other times when I think I've done well, seem to have a bit of a cool response. I always get good feedback from people afterwards, though, which I really appreciate.

These are all listed in reverse order, with the most recent first.

# 2017

## Devoxx, Belgium
***Eclipse MicroProfile: A quest for a lightweight and modern enterprise Java platform***  
Beginning with a little background for MicroProfile, explaining where it came from and how to get involved, I will cover what you get with MicroProfile today, and what you will get in the future. The Eclipse MicroProfile project evolves very quickly, so what this talk contains will likely change a lot right up to the day it's presented! Since I work for Payara - a vendor involved with MicroProfile - my demos will use that and show off some of the features we've added to make using MicroProfile APIs feel natural to someone who is used to Payara Server or Payara Micro.

## JavaOne, San Francisco
***[A Step-by-Step Guide from Traditional Java EE to Reactive Microservice Design](https://events.rainfocus.com/catalog/oracle/oow17/catalogjavaone17?search=HOL1320&showEnrolled=false)***  
This is really Ondrej's talk, but I'll be along for the ride. Ondrej has spoken at lots of conferences in 2016 and 2017 about Reactive Design principles with Java EE, particularly emphasising the fact that you don't need to learn a new framework to incorporate Reactive programming styles.

***[Baking a Java EE 8 Micro Pi](https://events.rainfocus.com/catalog/oracle/oow17/catalogjavaone17?search=TUT2112&showEnrolled=false)***  
This will be a tutorial and so will be expanded and revamped for JavaOne. Ondrej will be joining me for this one to help fill the gaps while I type and answer some questions.

## NetBeans Day, UK
***[Baking a Java EE 8 Micro Pi](https://www.payara.fish/see_us_at_the_netbeans_day_uk_2017)***  
A workshop to demonstrate a few cool ways of working with Payara Micro and some early previews of Java EE 8 APIs. My developer colleague [Andrew Pielage](https://www.payara.fish/andy_pielage) helped me out by smartening up my code and showing off some nice features of NetBeans while we did it. The end result was a couple of microservices inspired by a [demo of Payara Micro on a Raspberry Pi](http://blog.payara.fish/piyara-payara-micro-on-raspberry-pi-demo), with added JSON-B for serialising the data and JAX-RS 2.1 in the form of Server-Sent Events.

# 2016

## Devoxx, Belgium
*[Introducing the MicroProfile](https://cfp.devoxx.be/2016/talk/LYF-6510/Introducing_the_MicroProfile)*  
A group presentation from the vendors involved in the MicroProfile effort. [David Blevins](https://twitter.com/dblevins) lead the presentation and introduced a collaborative demo of the [MicroProfile Conference demo app](https://github.com/microprofile/microprofile-conference). Other speakers included [Heiko Braun (Red Hat)](https://twitter.com/heiko_braun) [Alisdair Nottingham (IBM)](https://twitter.com/nottycode) and [Andy Gumbrecht (Tomitribe)](https://twitter.com/andygeede).  
You can watch [the video of the talk on YouTube](https://www.youtube.com/watch?v=iG-XvoIfKtg)

*[A MicroProfile for MicroServices](https://cfp.devoxx.be/2016/talk/OXS-1955/A_MicroProfile_for_Micro_Services)*  
When I submitted this to the CFP, it wasn't clear exactly where we would be with the MicroProfile since it had only just begun. It turned out that 15 minutes wasn't anywhere near enough to cover everything, so it was very fortunate that I could join with others for the hour long presentation above. If you only have a few minutes, though, this is a decent summary of where things are at the end of 2016, though I would recommend watching David's conclusion to the above presentation as well.  
[The video for this presentation is on YouTube too.](https://www.youtube.com/watch?v=dyK6BcOh8N4)

## JavaOne, San Francisco
*[Cloud-Native Java EE [TUT3633]](https://oracle.rainfocus.com/scripts/catalog/oow16.jsp?event=javaone&search=TUT3633&search.event=javaone)*  
Despite sharing the name with a talk I've already done, this is a new talk. It builds on the concepts I've already presented but, as a tutorial, will be much more demo-heavy.

## JEEConf, Kiev
*[Cloud Native Java EE](http://jeeconf.com/program/cloud-native-java-ee/)*  
The key aim of this talk was to show that modern Enterprise Java is already ready for elastic, dynamically scalable deployments. It was the first outing for this talk, and I wasn't particularly happy with my delivery although I think the talk itself is good! The link above has a video of me which I haven't watched yet (I hate watching videos of myself)

*[Java EE Microservies Platforms - what's in it for me?](http://jeeconf.com/program/java-ee-microservices-platforms-whats-in-it-for-me/)*  
A different title for what was the same talk as I presented earlier at JAX in London.

## JAX Finance, London
*[Java EE Microservice platforms - which is best?](https://finance.jaxlondon.com/session/java-ee-microservice-platforms-which-is-best/)*  
This was an investigation into the differing approaches taken by Spring Boot, WildFly Swarm and Payara Micro. It was an odd talk - orginially concieved when I was an *independent* C2B2 consultant, but didn't make it to be accepted as a talk before I moved to work for Payara. So the independence went out the window. Then, the first talk that got accepted was to JDays on a date that I was going to be snowboarding in France! Steve, my boss, ended up being lumbered with a talk I hadn't written yet and that he couldn't be independent about either (sorry Steve!). He wrote a great talk, though, and I got to present it at JAX.

# 2015

## Devoxx Belgium
*[Fixing Performance Problems with Someone Else's Toolbox](https://www.youtube.com/watch?v=9DzzeJyh3H0)*  
This was a 15 minute "quickie" talk based on an experience I had with C2B2 on-site with a customer. What happens when you get hired to sort out some poor performance, but all of the tools you rely on are taken away - and not always replaced!

*[Java EE Microservices - The Payara Way](https://www.youtube.com/watch?v=fn444op9gW8)*  
This talk ended up being adapted and repackaged for my cloud Java EE talk. It's notable for a huge demo failure, which was totally my own fault. A couple of hours before the talk I realised that I was demoing Payara Micro to people who don't even know how simple it was to start! A simple `java -jar payara-micro.jar` is enough. So I added that in for a little extra clarification and context before the rest of the demos. What ended up happening was that I forgot to kill it and, when I was later trying to cURL to a deployed WAR, I was hitting the server I had started with no deployment. And, of course, I didn't notice until I was back in my hotel room!

## Devoxx Poland
A hands-on performance lab

# 2014

## Devoxx Belgium
*[Introducing Payara Server](http://www.payara.fish/see_payara_at_devoxx)*  
OK, this wasn't really a talk. Payara was launched at JavaOne in 2014 and we sponsored the movie night so, before Interstellar started, I had a captive audience and got to explain who we were and what we were doing with Payara Server. And [show off a video of our own](https://www.youtube.com/watch?v=ZdhGuoTYOIE)!

## JAX London
A hands-on performance lab

# 2013

## DOAG, Nürnberg
*[GlassFish 4 on Ubuntu Touch](http://www.c2b2.co.uk/c2b2_is_speaking_at_doag_2013)*  
This was a quick talk based on [a blog post I wrote](http://blog.c2b2.co.uk/2013/03/a-smartphone-as-jee-server-glassfish-on.html) which showed how easy it was to get GlassFish 4 running on a Samsung Galaxy Nexus running an early build of Ubuntu Touch. 2013 was a very different time (it feels odd saying that only just over 3 years later) and the really impressive thing was that a full JVM maanged to start a full Java EE app server, with no configuration changes *on 2013 hardware*. When people are talking so much about the modularity of Jigsaw coupled with bring-your-own-runtime style deployments like WildFly Swarm, the question needs to be asked: how much does this obsession with slimness really buy us?
