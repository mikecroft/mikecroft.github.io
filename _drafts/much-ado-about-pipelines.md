---
layout: post
title: Much ADO About Pipelines
comments: true
tags: 
 - Quarkus 
 - OpenShift
 - Kubernetes 
 - Azure
 - Pipelines
 - CI/CD
---

Recently I spent time with a customer who, in their words, have gone "all in" on Microsoft. From corporate IT to developer tools to application platforms. Not so long ago, that kind of statement would have made me shudder with despair, so it's testament to how Microsoft have reinvented themselves that using their tools has been such a pleasant experience.

For me, working mostly with the Azure DevOps (ADO) suite of applications, the standout tool was *ADO Pipelines*.

## Creating a Quarkus Native Image with ADO Pipelines

ADO Pipelines have a huge amount of extensions but none for GraalVM yet, so it might first appear that you would be stuck with JVM images. Not so; the lovely folks over at [Quarkus](https://quarkus.io) have provided a helpful bunch of container images on [Quay.io](https://quay.io/organization/quarkus) which can be used in a ***multi-stage build***

{% highlight dockerfile %}

FROM quay.io/quarkus/centos-quarkus-maven:19.2.1 AS build
COPY ./pom.xml ./pom.xml
COPY ./src ./src
RUN mvn -Pnative package -DskipTests

FROM registry.access.redhat.com/ubi8/ubi-minimal
WORKDIR /work/
COPY --from=build /project/target/*-runner /work/application
RUN chmod 775 /work
EXPOSE 8080
CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]

{% endhighlight %}  