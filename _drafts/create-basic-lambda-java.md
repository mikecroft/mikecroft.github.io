---
layout: post
title: Creating a Basic AWS Lambda Function with Java
comments: true
tags: 
 - AWS
 - Lambda
 - Cloud
 - Series
---

This post is part of [a series on serverless computing with AWS Lambda](), but is written as a standalone introduction to AWS Lambda with Java.

To follow along with this blog, there are a few things you'll need to have set up first:

* An AWS account
* Java 8
* Gradle

## 1. Create a New Project
My function will eventually be part of a larger project to control the lights in my home, so I've created a Gradle Java project called LightController, with the following `build.gradle`:

{% highlight gradle %}
group 'io.mikecroft.demo.homecontroller.lambda'
version '1.0-SNAPSHOT'

apply plugin: 'java'

sourceCompatibility = 1.8

repositories {
    mavenCentral()
}

dependencies {
    compile 'com.amazonaws:aws-lambda-java-core:1.1.0'
    compile 'com.amazonaws:aws-lambda-java-events:1.1.0'
}

task buildZip(type: Zip) {
    from compileJava
    from processResources
    into('lib') {
        from configurations.runtime
    }
}

build.dependsOn buildZip
{% endhighlight %}

The key parts to this are the two dependencies on the AWS Lambda SDK for Java and the task to build the compiled code into a zip distribution. When creating a Lambda function with Java, AWS expects your code to be uploaded as a Zip distribution, so the output of this task is what we'll upload to the dashboard later.

## 2. Create the LightController Class
Next, we need a class to handle incoming requests to the function. For this, we will need to implement the `RequestHandler` interface and override the `handleRequest(Object input, Context context)` method as shown:

{% highlight java %}
package io.mikecroft.demo.homecontroller.lambda;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;

public class LightController implements RequestHandler {

    @Override
    public String handleRequest(Object input, Context context) {
        return "Received message: " + input;
    }
}
{% endhighlight %}

All we're doing here is echoing the input back to the user to confirm that we've received the message and and then act on it. We'll use later blogs to do more interesting things.

## 3. Create the Function in the AWS Dashboard

## 4. Improve the Workflow
There is, of course, a plugin available for Gradle to speed up the deployment of Lambda functions. It requires some preconfiguration, though, since AWS credentials are sensitive and we don't want them in our build scripts.

* Create an [AWS Credentials file](http://docs.aws.amazon.com/cli/latest/topic/config-vars.html) (`~/.aws/credentials` or `~/.aws/config`)
* 
