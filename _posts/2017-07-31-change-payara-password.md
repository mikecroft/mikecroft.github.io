---
layout: post
title: Change The Payara Admin Password Non-Interactively
comments: true
tags: 
  - stackoverflow
  - payara
---

This post is, hopefully, going to be the first in a series of posts summarising some of the StackOverflow answers I've given in the past. I earned my first gold badge on the site this year - the "Unsung Hero" badge. What this effectively means is that I answer a lot of questions correctly and helpfully, but no-one cares.

The question that this post covers is one about [trying to access the admin console of a Payara Server or GlassFish instance DAS which is running in a container](https://stackoverflow.com/questions/42773521/secure-admin-must-be-enabled-to-access-the-das-remotely-acess-glassfish-admin).

## Background
For security reasons, it is not possible to remotely access the Payara Server admin console without "secure admin" being enabled. Essentially meaning that the admin console should **only** be accessible over HTTPS and should **only** be accessible to authenticated users. Somewhat irritatingly, the default admin user (`admin`) does not have a password set by default and one must be set before "secure admin" can be enabled. Setting this password manually is pretty easy - use the `asadmin change-admin-password` subcommand and follow the prompts - but when you're in an environment like Docker, this isn't going to be possible. Why did Sun and Oracle design things this way? Why not have a default password?

The answer is simple. Some years ago, now, I worked as [an independent consultant for c2b2](https://www.c2b2.co.uk/) and came across users of both JBoss and WebLogic who had Internet-facing application servers. For many people, that alone is a security risk, but when you consider that these versions of those servers had well known default admin user/password combinations and could be easily found via Google...you get the idea. [Raspberry Pi noted (and took action against) the problems with default, well-known user/password combinations] as recently as the end of 2016. Defaults can be convenient, but they just aren't worth the risk!

Back to the question. We know how to change the password in an *interactive* way, but there doesn't seem to be any option to the `change-admin-password` command to allow you tell it both the current and the new password all in one line. This is the problem that the user in the question has hit - ***how can the password be changed non-interactively in a Dockerfile?***

## Option One: Use the REST API
A relatively little-known feature of both Payara Server and GlassFish, the REST management interface is a really clever bit of engineering. When any new `asadmin` subcommand gets written and added, Payara Server parses it and generates a REST endpoint for it with no extra development effort! Neat!

There's a nice example of this in [a set of scripts I created to quickly set up a legacy-style Payara Server cluster](https://github.com/mikecroft/payara-docker-cluster/blob/master/run-cluster.sh#L61-L76) (using Shoal, rather than Hazelcast). The key part of the script is highlighted and reproduced below:

{% highlight bash %}
enableSecureAdmin() {
    # Set admin password
    docker exec das curl  -X POST \
        -H 'X-Requested-By: payara' \
        -H "Accept: application/json" \
        -d id=admin \
        -d AS_ADMIN_PASSWORD= \
        -d AS_ADMIN_NEWPASSWORD=$PASSWORD \
        http://localhost:4848/management/domain/change-admin-password

    docker exec das $RASADMIN enable-secure-admin
    docker exec das $ASADMIN restart-domain domain1
}
{% endhighlight %}
&nbsp;  
The first thing to get out of the way here is the Docker-specific parts. To run any bash command in a Docker container, you can simply prefix the command with `docker exec ${CONTAINER_NAME}` and the command will be passed to the container and run from there.

So, with that in mind, the main thing to be concerned about here is the `curl` command. I'm sending an HTTP `POST` request and adding three bits of data in the `POST` form:

* `id`
* `AS_ADMIN_PASSWORD`
* `AS_ADMIN_NEWPASSWORD`

I may write a follow-up post to go into more detail about the REST management interface at a later date but, for now, it should be enough to say simply that the `id` should be the id of the user whose password we want to change (here I'm changing the default `admin` user's password), `AS_ADMIN_PASSWORD` should equal the current password, and `AS_ADMIN_NEWPASSWORD` should equal what we want to change the password to.

In the example above, there is no value for `AS_ADMIN_PASSWORD` since the admin user, as we've said, does not have a password by default. After successfully running the command, you should get a JSON response similar to the following:

{% highlight javascript %}
{
  "message": "",
  "command": "change-admin-password AdminCommand",
  "exit_code": "SUCCESS",
  "extraProperties": {
    "methods": [
      {
        "name": "GET"
      },
      {
        "messageParameters": {
          "id": {
            "acceptableValues": "",
            "defaultValue": "",
            "optional": "false",
            "type": "string"
          },
          "newpassword": {
            "acceptableValues": "",
            "defaultValue": "",
            "optional": "false",
            "type": "string"
          },
          "password": {
            "acceptableValues": "",
            "defaultValue": "",
            "optional": "false",
            "type": "string"
          }
        },
        "name": "POST"
      }
    ],
    "commandLog": [
      "change-admin-password --AS_ADMIN_PASSWORD  --AS_ADMIN_NEWPASSWORD admin
      --DEFAULT admin --password  --newpassword admin --username admin"
    ]
  }
}
{% endhighlight %}
&nbsp;  
Following the `curl` to change the password, I complete the process by enabling secure admin and restarting the domain to apply the changes.

## Option Two: Use a Passwordfile
More eagle-eyed readers will have already spotted the downside to using the REST API to change the admin password for a completely fresh domain; since the domain does not yet have secure admin enabled, the REST endpoint is HTTP only, so passwords are being sent in clear text!

This is where [my original answer to the StackOverflow question](https://stackoverflow.com/questions/42773521/secure-admin-must-be-enabled-to-access-the-das-remotely-acess-glassfish-admin/42774130#42774130) comes in. I'll reproduce the answer below. Be aware that the Dockerfile I mention in the answer is [the official Payara Server Dockerfile from the 171 release](https://github.com/payara/docker-payaraserver-full/blob/171.1/Dockerfile) - from release 172, we've updated the Dockerfile to make use of a couple of other features.

---
&nbsp;  
To summarise, this method creates 2 files: a `tmpfile` which contains the default (empty) password and the desired new password, and a `pwdfile` which contains just the newly changed file.

If the contents of the `tmpfile` are:

```
AS_ADMIN_PASSWORD=
AS_ADMIN_NEWPASSWORD=MyNewPassword
```
&nbsp;  
Then the contents of `pwdfile` should be:

```
AS_ADMIN_PASSWORD=MyNewPassword
```
&nbsp;  
to change the password using asadmin, the first file must be used with the `change-admin-password` command, and the second with all future commands.

In docker terms, this looks like this (taken directly from the dockerfile linked above):

{% highlight dockerfile %}
ENV PAYARA_PATH /opt/payara41
ENV ADMIN_USER admin
ENV ADMIN_PASSWORD admin

# set credentials to admin/admin 

RUN echo 'AS_ADMIN_PASSWORD=\n\
AS_ADMIN_NEWPASSWORD='$ADMIN_PASSWORD'\n\
EOF\n'\
>> /opt/tmpfile

RUN echo 'AS_ADMIN_PASSWORD='$ADMIN_PASSWORD'\n\
EOF\n'\
>> /opt/pwdfile

RUN \
 $PAYARA_PATH/bin/asadmin start-domain && \
 $PAYARA_PATH/bin/asadmin --user $ADMIN_USER --passwordfile=/opt/tmpfile change-admin-password && \
 $PAYARA_PATH/bin/asadmin --user $ADMIN_USER --passwordfile=/opt/pwdfile enable-secure-admin && \
 $PAYARA_PATH/bin/asadmin restart-domain

# cleanup
RUN rm /opt/tmpfile
{% endhighlight %}
&nbsp;  

---
&nbsp;  
This answer is making use of options for the `asadmin` command itself. If you're already a GlassFish or Payara Server user, you are probably used to adding options to various `asadmin` subcommands, but you may not be as used to specifying options to `asadmin` itself. If that's the case, do take note of the fact that these options must come ***before*** the subcommand you want to use, and any options for the subcommand will come ***after*** the subcommand.

That's it! Payara Server is really quite flexible. There's usually at least one way to achieve your goal, often several ways. For any configuration which does not have a dedicated `asadmin` subcommand, the `set` subcommand can be used and, if you really don't know what's available, you can use the Payara Server `asadmin recorder` feature in the admin console which will write all the right commands to a file for you to replay at a later date.
&nbsp;  

---

&nbsp;  
*[This StackOverflow answer](https://stackoverflow.com/a/42774130/212224) by [Mike Croft](https://stackoverflow.com/users/212224/mike) is licensed under [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/). This derivative work is licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) by Mike Croft*
