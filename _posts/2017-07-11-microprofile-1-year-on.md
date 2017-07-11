---
layout: post
title: The MicroProfile Turns One
comments: true
tags: 
 - MicroProfile
---

As I write this blog post, on Tuesday 27th June 2017, I'm looking through memories of where I was on this day in 2016: participating in the keynote speech at Red Hat's DevNation conference in San Francisco.

<p style="text-align:center"><img width="70%" height="70%" src="{{ site.url }}/assets/mp-announcement.jpg"></p>

It was a Monday and, still reeling from the shock of [a certain small vote back home in the UK](https://www.theguardian.com/politics/2016/jun/24/britain-votes-for-brexit-eu-referendum-david-cameron), I joined Tomitribe's Theresa Nguyen, IBM's Alasdair Nottingham, the London Java Community's Martijn Verburg and Red Hat's Mark Little, as we announced a joint venture in MicroProfile.io.

In the last year, we've come a long way as a community. Here are a few highlights...

## How did we get here?
By JavaOne in September of 2016 there were implementations of MicroProfile from Red Hat, IBM, Payara and Tomitribe, and I was even able to use Payara's Microprofile edition in my JavaOne tutorial! By Devoxx Belgium in November, [I was able to stand on stage with Alasdair, Heiko, David and Andy](https://www.youtube.com/watch?v=iG-XvoIfKtg) to demonstrate our collaborative conference app; a separate microservice written by each vendor plus a simple frontend to show it all off.

It was around that time that work to bring the MicroProfile under the Eclipse Foundation began. From a very early stage, it was clear that a foundation would be needed to "own" the IP so that any community contributions would be protected. Eclipse was chosen and, in the months that followed around Christmas, a huge amount of behind-the-scenes work went on to make sure we were fully compliant and understoood everything that we needed to do as Eclipse Foundation members.

At that point, MicroProfile welcomed new members in the form of our Eclipse mentors, who have given a huge amount of their time to help smooth our journey; without their help, we would certainly not be where we are today!

Since then, there have been new specs created, ***lots*** of discussion and ***lots*** of work! It would be easy to miss everything that's gone on in our [Google Group forum](https://groups.google.com/forum/#!forum/microprofile), our [regular (public) calls](https://twitter.com/MicroProfileIO/status/879582237469007872), and all the efforts of individual specifications since everything seems to move at such a fast pace! It's important to remember that [hard work is not always obvious](https://twitter.com/katharineCodes/status/879302449152098304); so let's remedy that with an overview of what things have currently been acheived, and what things are still in progress.


## Where are we now?
Due in no small part to the growing pains of bringing together a new community of developers, all while fitting in to a new Foundation, there were inevitable delays in the work on the next version of MicroProfile. Fortunately, however, our Eclipse mentors and the MicroProfile community were very dedicated and work on new specs is now progressing at a very healthy pace!

A fantastic benefit of being an Eclipse project (aside from all the assitance and advice from our experienced mentors) is that we now have an Eclipse home for MicroProfile, [which shows very clearly all the contributions and activity](https://projects.eclipse.org/projects/technology.microprofile/who) happpening in our ever-increasing number of repositories!

The [current list of proposals](http://microprofile.io/projects) being actively worked on after a year includes:

* [Config](http://microprofile.io/project/eclipse/microprofile-config)
* [Fault Tolerance](http://microprofile.io/project/eclipse/microprofile-fault-tolerance)
* [JWT Role Based Access Control](http://microprofile.io/project/eclipse/microprofile-jwt-auth)
* [Health Checks](http://microprofile.io/project/eclipse/microprofile-health)
* [Metrics/Telemetry](https://github.com/eclipse/microprofile-metrics)
* Standardised properties

There are even a couple of existing APIs being reviewed for inclusion:

* Distributed Tracing (based on [opentracing.io](http://opentracing.io/))
* Standardised REST API documentation (based on [OpenAPI](https://www.openapis.org/)/Swagger)

In spite of the delays from our move to the Eclipse Foundation (and, really, just learning to work together efficiently) we are now in a position to release MicroProfile 1.1, which includes version 1.0 of the Config API, once final IP checks are complete. We also have dates and plans for versions 1.2 and 2.0, though the specs to be included in those versions is yet to be finalised. ([Join the discussion!](https://groups.google.com/forum/#!forum/microprofile))

Our [Eclipse Project Overview](https://projects.eclipse.org/projects/technology.microprofile) shows publicly our target dates for every release. Our plan is to time-box these releases so we will release on (or very near) those dates with whatever specifications have been finalised at the deadline. MicroProfile 1.1 has been slightly delayed from its initial target date since there was so much intellectual property to review and make sure we were legally clear to release.

Eclipse MicroProfile is also much stronger than it was a year ago. There was an expected large buzz at the beginning of the project as blogs were written and waves were made through the TwitterSphere but since then, we've been very pleased to welcome new corporate members of Eclipse Microprofile, proudly shown off on [the front page of microprofile.io](http://microprofile.io/):

* Hazelcast
* Fujitsu
* KumuluzEE
* Smartbear

All of the work that's been done and all of the activity that's still continuing gives us a very strong starting point to take us forward through the second half of 2017 and into 2018...

## Where are we heading?
Anecdotally, it seems that the pace of change is picking up. The MicroProfile effort has been quite grand in ambition right from the start, with many contributors across the world with differing amounts of other commitments. Bringing together such a diverse range of people has been tricky, at times, but the benefits of such an approach are really coming to fruition.

The specifications being developed specifically for MicroProfile are progressing more quickly now that many initial questions have been answered for other projects so, although Config 1.0 was the only additional spec to make it to MicroProfile 1.1, I am quietly confident that Fault Tolerance, Health Checks and JWT security will be done and usable shortly afterwards.

[<img width="40%" height="40%" align="left" src="{{ site.url }}/assets/mp-voting.png">](https://docs.google.com/forms/d/e/1FAIpQLSdy8_1rik03fepzs01_0RYGobT4fsnJIXMDAwnV0nZB1UbEng/viewform)

The technical side of the project is not the only side that has been putting in a lot of effort. Marketing specialists from all participating community members are [coming together to discuss branding and a revamped logo](https://groups.google.com/forum/#!topic/microprofile/diTj3_mx1bg) for the project that can be truly community-driven. To be a true community effort, there needs to be a consensus from all community members, so everyone who participates in any way is encouraged to make their voice heard and vote on our new logo choice!

<h3 style="text-align:center">
<a href="https://docs.google.com/forms/d/e/1FAIpQLSdy8_1rik03fepzs01_0RYGobT4fsnJIXMDAwnV0nZB1UbEng/viewform">Vote on your favourite logo by visiting the Google Form!</a>
</h3>

<br />

Tomitribe, who have generously provided hosting for the MicroProfile website over the past year, are putting a lot of effort into improving the site and helping to document the current projects.

Thanks to everything that's gone on before, we can see that the pace of development is increasing, there's more clarity on how to get things done, and [how someone new to the project can contribute](https://wiki.eclipse.org/MicroProfile). We've changed from a "[proposal approach](https://github.com/eclipse/microprofile-evolution-process)", which involved lots of discussion before work began, to a "[sandbox approach](https://wiki.eclipse.org/MicroProfile/FeatureInit)" which encourages people to get stuck in and write some code to demonstrate their proposal.

As MicroProfile 1.1 is gearing up for release, the community is looking forward to a strong 2017 and a stronger 2018!
