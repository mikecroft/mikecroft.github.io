---
layout: post
title: Deploy Quarkus Apps on Kubernetes with Tekton
comments: true
tags: 
 - Quarkus 
 - OpenShift
 - Kubernetes 
 - Tekton
 - CI/CD
---

A blog about [Tekton pipelines](https://github.com/tektoncd/pipeline).

## Steps
https://developers.redhat.com/blog/2020/01/08/the-new-tekton-pipelines-extension-for-visual-studio-code/ 






One of the things I do as a consultant is help customers at the beginning of their journey with OpenShift. What that actually involves will, of course, vary extensively depending on the needs of the customer and how prepared they are for change but it will usually involve some kind of demonstration application to show off some new capabilities that they may not yet be aware of. If a picture is worth a thousand words, a 10 minute demo could be worth a hour of talking.

In this case, my demo repository is a [Quarkus quickstart](https://github.com/quarkusio/quarkus-quickstarts/) - modified a little - which depends on a Postgres database and exposes some REST endpoints.