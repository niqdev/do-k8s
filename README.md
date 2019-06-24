# do-k8s

[![Build Status][travis-image]][travis-url]

[travis-image]: https://travis-ci.org/niqdev/do-k8s.svg?branch=master
[travis-url]: https://travis-ci.org/niqdev/do-k8s

This cluster definition is based on the common infrastructure for Continuos Deployment and Observability described in [edgelevel/gitops-k8s](https://github.com/edgelevel/gitops-k8s) and is customized for DigitalOcean.

## Setup

*TODO try to automate the steps below using the [API](https://developers.digitalocean.com/documentation/v2)*

1) Create a Kubernetes cluster on DigitalOcean and download the config
2) Add a domain `example.com`
3) Bootstrap the cluster `make`
4) Port-forward ArgoCD and update `applications-do` parameters
    * `digitalOceanToken`
    * `domain`
    * *TODO fix argocd secrets [issue](https://github.com/argoproj/argo-cd/issues/1786)*
4) Sync all the applications

Exposed services
* `ambassador.example.com`
* `prometheus.example.com`
* `alertmanager.example.com`
* `grafana.example.com`
* `bot.example.com`
* *TODO* `argocd.example.com`
* *TODO* `kibana.example.com`
* *TODO setup TLS*
