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


<img />


All the experiments I ran can be found in [my GitHub repository](https://github.com/mikecroft/leaky-secrets/tree/main). The reproducer is [in directory `1-leaky`](https://github.com/mikecroft/leaky-secrets/tree/main/1-leaky)


## Finding a Solution
After I'd seen how easy it was to reproduce the problem, I looked for solutions. There is [a standard, OCI-native solution to mounting secrets into a container build](https://docs.podman.io/en/v5.4.0/markdown/podman-build.1.html#secret-id-id-src-envorfile-env-env-type-file-env) but, since the BuildConfig `Docker` strategy wraps the underlying container build process, not all features are exposed to users, including this one. An OpenShift Pipelines build, powered by Tekton, would be a sensible choice here because all the standard build options for whichever build tool is being used would be available - but we want to make sure BuildConfigs can be made secure.

Fortunately, the OpenShift documentation provides exactly the answer I was looking for: [Build Volumes](https://docs.redhat.com/en/documentation/openshift_container_platform/4.18/html/builds_using_buildconfig/build-strategies#builds-using-build-volumes_build-strategies-docker).

Build volumes are very useful not just for keeping sensitive data secret but, since anything mounted this way is not persisted in any layer of the final image, it can keep final image sizes much smaller.


{% highlight yaml %}
strategy:
  dockerStrategy:
    from:
      kind: ImageStreamTag
      name: ubi-minimal:9.5
    volumes:
      - name: secrets
        mounts:
        - destinationPath: /tmp
        source:
          type: Secret
          secret:
            secretName: build-volumes-secret
            items:
              - key: .aws-credentials
                path: .aws/credentials
              - key: .env
                path: .env
{% endhighlight %}  
&nbsp;  


## Exploring Other Options
Since this wasn't just a 

**Custom Build Strategy**  
I investigated using the Custom build strategy based on [the overview in the documentation](https://docs.redhat.com/en/documentation/openshift_container_platform/4.16/html/builds_using_buildconfig/custom-builds-buildah#custom-builds-buildah)

**Squashing Build Layers**  
After finding [the `imageOptimizationPolicy: SkipLayers` option](https://docs.redhat.com/en/documentation/openshift_container_platform/4.16/html/builds_using_buildconfig/build-strategies#builds-strategy-docker-squash-layers_build-strategies) , I created a test to run the same Docker strategy build with and without that option. I even included an environment variable pulled in from a secret in the build config.

I pulled and saved both images and found that the secrets were visible in the standard build, but not in the build which had its layers squashed.

