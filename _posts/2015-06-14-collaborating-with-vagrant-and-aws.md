---
layout: post
title: Collaborating with Vagrant and AWS
comments: true
tags: 
 - Vagrant
 - AWS
---

I've been gradually integrating Vagrant into my workflow for a while now. I love how it gives me the chance to try something totally new out in a completely separated environment that I can then just bin if I get it all wrong and I know that nothing in my host system has been contaminated. Docker can acheive basically the same thing, but Vagrant fits my workflow very well.

Vagrant is quite extensible and has plugins for [VMWare](http://www.vagrantup.com/vmware), [Microsoft Azure](https://github.com/MSOpenTech/vagrant-azure)  and [Amazon Web Services](https://github.com/mitchellh/vagrant-aws) as well as the default VirtualBox, so the same provisioning script can be used among your development team as well as in production in the cloud or on your self-hosted VMWare platforms. The only thing you'll need to keep the same is the OS that you want to provision - configured by Vagrant boxes.


### Switching from VirtualBox to AWS
I've recently needed to use the AWS plugin for a talk for the [West Midlands JUG](http://www.meetup.com/West-Midlands-JUG/events/221956346/) in a demo, and this presented me with a problem. The example in the README of the Vagrant plugin looks like this:

{% highlight ruby %}
Vagrant.configure("2") do |config|
  config.vm.box = "dummy"

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = "YOUR KEY"
    aws.secret_access_key = "YOUR SECRET KEY"
    aws.session_token = "SESSION TOKEN"
    aws.keypair_name = "KEYPAIR NAME"

    aws.ami = "ami-7747d01e"

    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "PATH TO YOUR PRIVATE KEY"
  end
end
{% endhighlight %}

For anyone reading this who is not familiar with AWS, the two important bits to note are the `aws.access_key_id` and `aws.secret_access_key`. If the word "*secret*" wasn't enough to tell you it shouldn't really be shared freely on Github, the reason you shouldn't be spreading that around is that that ID/Key pair gives anyone with those access to your Amazon account. They can be revoked very easily, but it's absolutely not the sort of security breach you want. 

So now, the Vagrantfile which previously enabled us to share specific configurations among our teams and the community can now no longer be shared. Which is certainly a problem, when that is precisely the reason why you want to use it!

### Enter the Vagrant-Env Plugin
Ideally, what I wanted to do was to be able to use placeholder variables that I could store in a separate file added to my `.gitignore` file. Then, I could just reference these variables and be confident that they wouldn't be uploaded to a public Github repository.

What I found was the [vagrant-env](https://github.com/gosuri/vagrant-env) plugin, which does exactly what I wanted:

{% highlight ruby %}  
Vagrant.configure("2") do |config|
  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV['AWS_ACCESS_KEY']
    aws.secret_access_key = ENV['AWS_SECRET_KEY']
  end
end
{% endhighlight %}

After making sure the plugin was installed:

    $ vagrant plugin install vagrant-env

I added the actual values in a file called `.env` and then added that to my `.gitignore`. The README for the plugin does say that you need to specifically enable the plugin with `config.env.enable` in the Vagrantfile, but I left that out and found that it still worked fine.

I haven't used Microsoft Azure, yet, but I would expect a similar use case would require the use of the `vagrant-env` plugin, but in any case, the plugin is incredibly versatile, despite how simple it is.
