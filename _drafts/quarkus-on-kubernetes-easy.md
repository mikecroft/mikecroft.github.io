---
layout: post
title: Quarkus on Kubernetes the Easy Way
comments: true
tags: 
 - Quarkus 
 - OpenShift
 - Kubernetes 
 - Dekorate
 - Series
---

I've been using Quarkus a lot lately. Not because I particularly need to; I just enjoy using it so much that I've found myself looking for ways to shoehorn it in to whatever it is I'm doing at the time.

> *Oh, what's that? You want a demonstration of CI/CD in OpenShift? Let me just create a new Quarkus project first...*

I think the thing that keeps bringing me back to Quarkus is how often I find new features that have been added to *make my life easier*. One of the features that I've found most useful and time-saving is [the Kubernetes extension](https://quarkus.io/guides/kubernetes).

A really common complaint from people who are new to Kubernetes is the significant complexity and large number of new concepts to learn. Also, [there's the YAML](https://noyaml.com/). When I was first learning Kubernetes, my main concern was how I could use it to be productive, not how I should follow all the best practices right away. 

Dekorate is a really handy project which uses annotations, properties or both to let you generate some Kubernetes objects even if you don't really understand the fundamentals of how everything fits together just yet.

## Generating YAML with the Kubernetes Extension
Before we can use the extension, we're going to have to add it to our project. Assuming you're in the root directory of an existing project, or one you've chosen from [the Quarkus quickstarts](https://github.com/quarkusio/quarkus-quickstarts) repository, 

{% highlight bash %}
mvn quarkus:add-extension -Dextensions="kubernetes"
{% endhighlight %}
&nbsp;   
Once the extension is added, we can simply specify a bunch of properties which Maven or Gradle will parse and feed into Dekorate on a `mvn package` or `gradle build`.

You can get a much more comprehensive (and, likely, up-to-date) overview of all the possible options from the official guide so I won't labour the point, but there's a property for most things you could want, and options to generate slightly different objects for OpenShift than Kubernetes. One feature I've found very useful is the way you can override Quarkus settings with Kubernetes environment variables, courtesy of MicroProfile Config:

{% highlight properties %}
# datasource
quarkus.datasource.url = jdbc:postgresql://localhost:5432/quarkus
quarkus.datasource.driver = org.postgresql.Driver
quarkus.datasource.username = quarkus
quarkus.datasource.password = quarkus

# OpenShift
kubernetes.deployment.target = kubernetes,openshift

openshift.env-vars[0].name = QUARKUS_DATASOURCE_URL
openshift.env-vars[0].value = jdbc:postgresql://postgresql:5432/quarkus
{% endhighlight %}
&nbsp;   
In this example, I'm setting the default datasource URL to point to a local PostgreSQL container, but using an environment variable to override the URL with the name of the Kubernetes service for when it runs in my OpenShift cluster. I'm taking advantage of the fact that property names map to environment variables simply by capitalising them and replacing dots with underscores.

I'm also generating OpenShift resources, including a `BuildConfig` for an `s2i` build. Because Quarkus uses a thin jar + libs approach to packaging, we also need to pass the right environment variable to the `s2i` build so that it copies over the right artifact and libraries:

{% highlight properties %}
s2i.build-env-vars[0].name = ARTIFACT_COPY_ARGS
s2i.build-env-vars[0].value = -p -r lib/ *-runner.jar
{% endhighlight %}
&nbsp;   