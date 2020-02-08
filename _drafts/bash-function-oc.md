---
layout: post
title: Use a Bash Function to Override The oc Command
comments: true
---

Here's a trick you'll never use: define your own Bash function to override the default settings on the `oc` binary. Like so:

{% highlight bash %}
# Defines a function to point oc to a specific
# OpenShift cluster with URL and auth token
# set by environment variables
function oc {
    PARAMS="--server=$OPENSHIFT_CLUSTER --token=$AUTH_TOKEN"

    for PARAM in "$@"
    do
        PARAMS="${PARAMS} \"${PARAM}\""
    done

    sh -c "command oc ${PARAMS}"
}
{% endhighlight %}
&nbsp;

Before I describe what this function is doing and why it's written the way it is, it's probably important to cover the reason for it in the first place and why you'll (probably) never have cause to use it.

## An Extremely Specific Scenario
The need for this solution came from a customer engagement where, as with all very specific lists of requirements, there were improvements needed to an OpenShift installation that had grown and evolved from a very early version. This meant Jenkins build jobs constructed in ways which seem odd from an OpenShift 3.11 perspective, but where necessary when first written.

In this case, there were three separate OpenShift clusters: nonprod and prod as well as a third 'tools' cluster which was to be used to orchestrate CI/CD pipelines across the other two OpenShift clusters.

When I arrived, nonprod and prod were not connected in any way, so there were still manual steps in the pipeline. Since the job involved getting the Jenkins instance in the orchestrator cluster to..............
