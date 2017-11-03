---
layout: post
title: Async Home Automation From AWS Lambda with SQS and Java
comments: true
tags: 
 - AWS
 - Lambda
 - SQS
 - Cloud
 - Series
---

JavaOne 2017 has been and gone and one thing that appeared on my radar this year was [serverless computing](https://martinfowler.com/articles/serverless.html). Not only because of a couple of announcements - Oracle have now launched their [fn Project](http://fnproject.io/) platform and Microsoft have [announced support for Java in their Azure Functions platform](https://techcrunch.com/2017/10/04/microsofts-azure-functions-adds-support-for-java/) - but also because of an interesting conversation I had with [Ryan Cuprak](https://www.slideshare.net/rcuprak). He, like me, has been working with AWS a lot and had been experimenting with [AWS Lambda](http://docs.aws.amazon.com/lambda/latest/dg/welcome.html).

While I had initially dismissed serverless for Java use cases due to JVM startup times, I know that it's one of the core languages that AWS supports and there must be a good reason for that. While talking to Ryan, I asked him "why would I, a Java EE user, be interested in something like AWS Lambda?". His answer was logical, pragmatic, and one I really should have thought of myself.

## What Function Can Lambda Serve for Java EE Developers?
The core added-value of serverless for server-side developers is not that it can replace your entire stack, but that it can be used in partnership with your current applications, whether it's split into microservices or a monolith. Ryan's example was using Lambda with API Gateway (to provide a REST endpoint) and AWS Cognito to provide easy authentication against Google or Facebook for example. This is an easy way to offload some of the heavy lifting for authentication while keeping your core business logic in your application server. Another huge advantage is that, when your infrastructure is already in AWS, you can take advantage of Lambda's pricing, where the first 1 million requests per month are free.

All this gave me an idea. A few months ago, I was looking at running an MQTT broker on my Raspberry Pi at home. Despite knowing about [the security implications](https://www.raspberrypi.org/blog/a-security-update-for-raspbian-pixel/), I thought it was a good idea to put the Pi on the Internet so I could manage it remotely. 24 hours and 97 failed login attempts later, I took it off the Internet. Since then, I haven't bothered trying to expose anything on my local network to the outside world because of security concerns. All I need for my scenario is a way to send messages into my home network, so a combination of AWS Lambda, AWS SQS and Payara Micro (with an SQS Cloud Connector) will allow me to configure Payara Micro to pull messages from a cloud-based broker, rather than a broker within my home network. No more open-to-the-world ports!*

Since I don't plan on exceeding the limit of 1 million requests for either Lambda or SQS, all this will be completely free.

## What Pieces Do We Need To Put Together?
There are a couple of things we need to get working to create this scenario. Each one has a few gotchas which tripped me up along the way so, to avoid making this a very long post (or not explaining them properly), I'll put the example together in a few steps over several posts:

***[Step 1](): Create a Lambda Function***
In this step, we'll create a generic Lambda function which performs the most basic task of echoing the input back to the requester.

***[Step 2](): Modify the Function to Send a Message to SQS***
Building on the first step, we will use the AWS SDK to forward the input to an SQS queue.

***[Step 3](): Create an Application on Payara Micro to Consume the Message***
Once we can queue messages to SQS, we will need to do something with them. This step will use [the SQS Cloud Connector JCA adapter](https://github.com/payara/Cloud-Connectors/tree/master/AmazonSQS) to consume messages with an MDB.

***[Step 4](): Use API Gateway to Call the Function***
The most flexible way to invoke Lambda functions is to use API Gateway to create a REST API for the function. This step will look at this process.

## Going Further with IoT
All these steps have only really got us as far as a proof-of-concept. This post has - deliberately - been focused solely on the serverless computing options provided by AWS but there are a couple of ways we could take the smart home concept I used here forward; we could maintain a single Lambda function to receive and queue any command and have Payara Micro figure out what to do with it, or we could create multiple endpoints and functions to send messages to different queues based on the "thing" we want to control.

To really take this into smart home territory, the [openHAB](https://www.openhab.org/) project is a great foundation to build from. If you're happy enough with Javascript and Node.js, then IBM's [Node-RED](https://nodered.org/) is also an option. These both offer very different ways of controlling smart appliances, so it's worth doing a bit of research before investing too heavily in either.

Both have very good community support and forums and are pretty easy to get started with.

----

*_Of course, this approach is still not perfect for security. SQS queues can be secured, but I still need to make sure that bad data won't be sent to this queue and that my application will reject malformed messages. This is just a proof-of-concept, though._
