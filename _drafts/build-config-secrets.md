---
layout: post
title: Keeping Secrets Safe in OpenShift Builds
tags: 
 - OpenShift
 - CI/CD
 - Builds
comments: true
---

One of the hardest security risks to mitigate is that of human error. In a world of increasingly containerised workloads, [leaking secrets in container images is a significant concern](https://dl.acm.org/doi/abs/10.1145/3579856.3590329). A similar problem of secret leaking in Git repositories has largely been dealt with through tooling like [pre-commit hooks](https://pre-commit.com/hooks.html), so what is the equivalent for container image builds? What are the risks, and how can we avoid them?


When running a container image build, it's not uncommon for there to be a to need to use some kind of secret - an AWS credentials file, for example - as part of the build. Users may be surprised to learn that simply removing the secret after use is enough to prevent the secret from being present in the final image.


## Verifying the Problem
To properly understand how secrets can be accidentally leaked, my first step was to create a reproducer. I created a simple Dockerfile which copied in a `.env` file with some a dummy GitHub token in, and then removed the file:

{% highlight dockerfile %}
FROM registry.redhat.io/ubi9/ubi-minimal:9.5

COPY .env .
ENV AWS_CREDS=.aws/credentials

RUN microdnf install -y python && \
    mkdir .aws && \
    echo "AWS_ACCESS_KEY_ID=AKIA0123456789ABCDEF" >> $AWS_CREDS # notsecret
RUN echo "AWS_SECRET_KEY=12ASD34qwe56CXZ78tyH10Tna543VBokN85RHCas" >> $AWS_CREDS # notsecret 

RUN cat .env && \
    cat ${AWS_CREDS}

RUN rm .env && \
        rm ${AWS_CREDS}

ENTRYPOINT [ "python" ]

CMD [ "-m", "http.server", "8080" ]
{% endhighlight %}  
&nbsp;   
I used the [Docker image inspection tool Dive](https://github.com/wagoodman/dive) to analyse the image and saw the ID of the layer where the file was added. Viewing the layer from the tarball in `vim` clearly showed the contents of the file.
