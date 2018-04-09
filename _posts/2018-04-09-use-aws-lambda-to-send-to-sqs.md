---
layout: post
title: Use AWS Lambda to Send a Message to an SQS Queue
comments: true
tags: 
 - AWS 
 - Lambda
 - SQS 
 - Cloud
 - Series
---


This post is part of [a series on serverless computing with AWS Lambda](https://mikecroft.io/2017/11/02/async-home-automation-lambda-sqs.html), and follows on directly to [the previous post on creating a basic AWS function](https://mikecroft.io/2017/11/27/create-basic-lambda-java.html). This post will assume you've read the previous one and modifies the code presented there.

Since the original intention of the series is to show how AWS Lambda and SQS can be used to expose a service to the Internet for free (even if you've already used up your AWS Free Tier allocation), the next step is to get the function we just made to send a message to an SQS queue.

The first step is to create a new method called `sendMessage()` which uses the Amazon SQS API to put a `String` message on a named queue. We could create the queue manually in the AWS dasboard at this point, but that's not necessary since the queue will be created if it doesn't exist.

{% highlight java %}

package io.mikecroft.demo.homecontroller.lambda;

import com.amazonaws.regions.Regions;
import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSClientBuilder;
import com.amazonaws.services.sqs.model.CreateQueueRequest;
import com.amazonaws.services.sqs.model.SendMessageRequest;
import com.amazonaws.services.sqs.model.SendMessageResult;

/**
 * Created by mike on 10/10/17.
 */
public class LightController implements RequestHandler<Object, Object> {

    @Override
    public Object handleRequest(Object input, Context context) {
        return sendMessage(input.toString(), "lights");
    }

    private String sendMessage(String msg, String q) {
        AmazonSQS sqs = AmazonSQSClientBuilder.standard()
                .withRegion(Regions.EU_WEST_1)
                .build();

        CreateQueueRequest createQueueRequest = new CreateQueueRequest(q);
        String myQueueURL = sqs.createQueue(createQueueRequest).getQueueUrl();

        System.out.println("Sending msg '" + msg + "' to Q: " + myQueueURL);

        SendMessageResult smr = sqs.sendMessage(new SendMessageRequest()
                .withQueueUrl(myQueueURL)
                .withMessageBody(msg));

        return "SendMessage succeeded with messageId " + smr.getMessageId()
                + ", sequence number " + smr.getSequenceNumber() + "\n";
    }
}

{% endhighlight %}

## Gotchas
The first thing that might trip people up - particularly using Java on AWS Lambda - is hitting a timeout. Because Java needs time for the JVM to boot and load classes into memory. While 10 seconds was plenty with a simple echo function, that won't cut it here. Increasing to 20 seconds didn't (initially) give enough time to avoid the timeout, but that was explained by the way the error message changed when I doubled the timeout to 40 seconds - an `OutOfMemoryError`.

The eventual changes I used so that my new function worked as smoothly as my initial one was to both set the `timeout` to 20 and the `memorySize` to 256, as shown below:

{% highlight gradle %}
task deploy(type: AWSLambdaMigrateFunctionTask, dependsOn: build) {
    functionName = "LightController"
    handler = "io.mikecroft.demo.homecontroller.lambda.LightController::handleRequest"
    role = "arn:aws:iam::${aws.accountId}:role/lambda_light_controller"
    runtime = Runtime.Java8
    zipFile = buildZip.archivePath
    memorySize = 256
    timeout = 20
}
{% endhighlight %}
&nbsp;  
We could, of course, bump up both values much higher to give a lot of headroom for further expansion of the function, but cost needs to be taken into account as well. While Lambda does give the first 1M requests for free, it also limits the free tier by duration and allows 400,000 GB seconds of compute time. For this case, the limit is still very high indeed and isn't anything to worry about, but it's certainly something to bear in mind when estimating production costs.

Secondly, it's important to note how easy it us to get caught out if you have more than one AWS account here. [It certainly happened to me](https://stackoverflow.com/questions/46676287/aws-cli-and-java-sdk-return-incorrect-urls-for-sqs-queues)! Where I got caught out was in setting up my AWS credentials locally and invoking my function. I could see that my function worked successfully, so I opened up my AWS console and looked for the message in the SQS queue, but found nothing there. After a lot of confusion, and asking about it on StackOverflow, I found the missing messages in an SQS queue on another AWS account.

What really threw me was that I hadn't realised the SQS queue could be created if it didn't exist as a default behaviour. My first "lights" queue was created manually but, in testing my code, I had inadvertantly created an identical queue in a separate account!

Fortunately, the answer was staring me in the face, though I didn't recognise it. The output of testing the function in the dashboard was as follows:

```
START RequestId: 0b6e1b4a-367c-11e8-ac75-87c943e47109 Version: $LATEST
Sending msg '{msg=A message from the AWS Dashboard}'
    to Q: https://sqs.eu-west-1.amazonaws.com/9**********2/lights
END RequestId: 0b6e1b4a-367c-11e8-ac75-87c943e47109
```
&nbsp;  
As you can see, the queue output (masked here) included the account number for the AWS account where the queue was located. Discovering that the number was an account number rather than a simple queue ID made the answer obvious.


## Next...
This has been a relatively short blog, overall, but there hasn't been much to show. The API is simple and easy to get up and running with. The next step will be introducing Payara Micro to consume the SQS message and process a command.

