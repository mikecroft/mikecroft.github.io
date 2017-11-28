---
layout: post
title: Devoxx Belgium 2017
comments: true
tags: 
  - conference
  - payara
  - microprofile
---

This November I once again found myself in Antwerp at Devoxx Belgium. I've attended every one since we first launched Payara back in 2014! Over the years, I've been to quite a few conferences and I have to say that Devoxx Belgium is always my favourite. Stephan always finds a way to make each one unique!

<img src="{{ '/assets/devoxx-be-2017/microprofile-talk.jpg' | absolute_url }}" style="float:left;margin:4px 10px 5px 0px;">
Twice I have attended as an exhibitor as well as speaker, and twice I have attended solely as a speaker. Each year, the quality of talks seems to rise, which always seems to add to the pressure when preparing my own talks!

This year, I had more time to enjoy the conference as an attendee than usual and was able to attend some really fantastic talks! As usual, there are lots on the [Devoxx YouTube channel](https://www.youtube.com/channel/UCCBVCTuk6uJrN3iFV_3vurg) but the standout for me this year was [Martin Görner's "Serverless datastream processing" hands-on lab](https://cfp.devoxx.be/2017/talk/VNG-6981/Serverless_datastream_processing). Even though the labs aren't filmed, this one is available [from Google CodeLabs](https://codelabs.developers.google.com/codelabs/cloud-dataflow-nyc-taxi-tycoon/#0). For me, as someone who has had zero experience with any kind of datastream processing, it was all a bit mindblowing, but the lab is structured in such a way that concepts become clearer with each step, even if they aren't immediately clear.

## MicroProfile: A Quest for a Lightweight and Modern Enterprise Java Platform
As for me, my main presentation was on the [Eclipse MicroProfile](http://microprofile.io). The talk was a (very) brief introduction to what MicroProfile is, followed by a whistle-stop tour of all the specifications available in the 1.2 release:

* Config 1.1
* Health Check 1.0
* Fault Tolerance 1.0
* Metrics 1.0
* JWT Propagation 1.0

All the slides from my talk, as well as the recording is available on SlideShare, embedded below.
<iframe src="//www.slideshare.net/slideshow/embed_code/key/idQjwFBuWBtpGx" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe>

I had hoped to have time to show an in-depth demo but, due to the sheer amount of things to talk about from the new specifications, I had to trim this right back to the briefest possible look at some features in just a minute or two!

## Opening Up Java EE: Panel Discussion
In the evening of the same day as my MicroProfile talk, I was asked to join a panel discussion on Java EE and its move to the Eclipse Foundation under the newly formed ["EE4J" umbrella project](https://projects.eclipse.org/projects/ee4j/charter).

<img src="{{ '/assets/devoxx-be-2017/ee4j-panel.jpg' | absolute_url }}" style="float:right;margin:4px 0px 2px 10px;">
There were representatives from IBM (Steve Poole), Tomitribe (Roberto Cortez), Payara (myself), Red Hat (Dimitris Andreadis), Oracle (David Delabassee), the community (Ivar Grimstad) and it was ably chaired by JCP EC member Martijn Verburg.

There were lots of great questions and it seemed that the answers we were able to give were satisfactory. The EE4J effort is still very new and there are lots of details that still need to be worked out, so there were lots of caveats to add to answers.

It's always a little nerve-wracking for me to stand and give answers in any situation like this when I am representing Payara; all my community activity gets a little disclaimer that my views are not necessarily those of Payara (as any engineer would for any other company) but these situations always seen to have more eyes and ears watching! Thankfully, I didn't say anything wrong!

[The video of the discussion can be found on the Devoxx YouTube channel](https://www.youtube.com/watch?v=HRNskFH1MoU).

As usual, I've added details (and links to videos where available) for my talks [to the conferences page]({{ site.url }}/conferences/) where I list all the talks I've done going all the way back to 2013!
