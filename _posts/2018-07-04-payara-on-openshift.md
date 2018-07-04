---
layout: post
title: Payara Micro on OpenShift
comments: true
tags: 
 - Payara
 - OpenShift
---

I've been spending a while learning the ins and outs of OpenShift. The key thing I've learned so far is that the vast majority of the quick starts and introductory tutorials for OpenShift are exactly the same as Kubernetes in that they ignore all complexity in favour of getting you up and running with something that "just works" as fast as possible.

These tutorials are pretty good, for what they are, in that they work surprisingly well and are useful to quickly see the value of OpenShift. The problem from my perspective is that much of the cogs and gears under the covers are hidden away in the tutorials and if you try to have a look at how things work, you get quickly overwhelmed with all the low-level moving parts.

## OpenShift For The Impatient
One of the appealing things about OpenShift is how you can get up and running with the benefits of Kubernetes without really knowing much about the platform underneath. A problem I found, though, was that lots of OpenShift tutorials are built on pre-existing image, or using S2I to convert source code into a container.

I wanted to know how I could take an existing dockerised application and make OpenShift run it. Without having to change anything in my application and without having to go anywhere near any kind of YAML.

## Some background
The source for all of this is available in GitHub - [mikecroft/payara-openshift](https://github.com/mikecroft/payara-openshift)

This example will use **minishift**, so it can all be run locally, although there is nothing stopping you from deploying to any OpenShift instance you happen to have available. OpenShift is compatible with upstream Kubernetes, but adds a few extra things. One of the challenging things about learning one platform or the other is knowing which features only exist in OpenShift and which features are simply renamed from upstream Kubernetes. Here, I'm only going to focus on OpenShift because this is just a quick primer rather than anything in depth.

This demo is going to use the docker daemon and registry provided by minishift for an easy way to go from just a Dockerfile to a service with scalable pods.

This method will only require a Dockerfile and, by the end, we will have performed the following high-level steps:

1. Configured the local shell to use the Minishift docker daemon instead of the default.
2. Built our docker image and pushed it to the registry
3. Created a new project and a new app using an *image-stream* derived from the newly pushed image
4. Scaled the app and watched it cluster exactly as it does locally. 

## Actual Steps

**Step 0**  
The steps to get this done are pretty simple. First, make sure the environment is set up. [Download and install Minishift](https://www.openshift.org/minishift/), and make sure you have the `oc` binary added to the `$PATH` by running `eval $(minishift oc-env)`.

We will also need an application (the venerable clusterjsp.war) added to a Dockerfile:

```
FROM payara/micro
COPY clusterjsp.war $DEPLOY_DIR
```
&nbsp;  
The official Payara Micro Docker image already has an environment variable for the deployment directory, so we can be sure that the app will be run on Payara Micro. Layering a thin WAR on top of a standard Payara Micro runtime image like this means that the resulting image we build will be very small and therefore very quick to rebuild any changes and push them to the OpenShift registry:

```
➜  ~ docker history mcroft/payara-micro-test
IMAGE               CREATED             CREATED BY                            SIZE
a93da4bc5adf        18 hours ago        /bin/sh -c #(nop) COPY file:8a2cca…   3.06kB  
```
&nbsp;  
Now there's an OpenShift environment we can use, and an app we can run in it, we can create a service.

**Step 1**  
First we need to make sure that we switch the local `docker` command to use the minishift daemon. Fortunately, this is as easy as running `eval $(minishift docker-env)` in the terminal you want to use. The command will set a couple of environment variables so that future `docker` command invocations will now affect the minishift environment rather than your host.

**Step 2**  
Next, we need to log in to the Minishift docker environment and then build, tag and push our docker image to the registry. Assuming you are in the same directory as the Dockerfile:

```
docker login -u developer -p $(oc whoami -t) $(minishift openshift registry)
docker build -t payara-micro-test .
docker tag payara-micro-test $(minishift openshift registry)/payara-project/payara-micro-test
docker push $(minishift openshift registry)/payara-project/payara-micro-test
```
&nbsp;  
What all that gives us is a Docker image that Minishift can use as an ***image stream*** in creating a new service.

**Step 3**  
If you haven't already created a new OpenShift project, then you will need to do that before creating a new app:

```
oc new-project payara-project
oc new-app --image-stream=payara-micro-test
```
&nbsp;  
At this point, we can expose the service using the CLI with `oc expose svc payara-micro-test` but this command will simply take the first port it finds and expose that. The Payara Micro image exposes a number of ports, including `4848` and that is the one that OpenShift will expose. We need to specify that we want port `8080` in the command:

```
oc expose svc payara-micro-test --port=8080
```
&nbsp;  
Now the app is running with a route exposed, we can get at our route through the dashboard:

```
minishift dashboard
```
&nbsp;  
A browser window should open with the dashboard in view. Select the project you created and click the route to be taken to the application. In the case of this example, we need to append the path `/clusterjsp` since it doesn't get deployed to the root context, though this can be changed by renaming the file to ROOT.war for convenience.

In my case, the path was `http://payara-micro-test-payara-project.192.168.64.2.nip.io/clusterjsp`. This will likely be the same for you although, if you created multiple named routes, you may find the `payara-micro-test` part of the URL is replaced with something like `web-route` or whatever name you chose.

