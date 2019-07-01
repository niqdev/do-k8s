# do-k8s

[![Build Status][travis-image]][travis-url]

[travis-image]: https://travis-ci.org/niqdev/do-k8s.svg?branch=master
[travis-url]: https://travis-ci.org/niqdev/do-k8s

This cluster definition is based on the common infrastructure for Continuos Deployment and Observability described in [edgelevel/gitops-k8s](https://github.com/edgelevel/gitops-k8s) and is customized for DigitalOcean

* [Setup](#setup)
* [Applications](#applications)

## Setup

The [bootstrap](bootstrap) chart has two main purposes
* import the [seed](https://github.com/edgelevel/gitops-k8s/tree/master/charts/seed) chart to reuse and extend the common infrastracture
* declare an [Application of Applications](https://argoproj.github.io/argo-cd/operator-manual/cluster-bootstrapping/#application-of-applications-pattern)

To setup a cluster follow these instructions
1) install the [required tools](https://github.com/edgelevel/gitops-k8s#prerequisites)
2) create a 3 nodes Kubernetes cluster on [DigitalOcean](https://www.digitalocean.com/docs/kubernetes)
3) configure the [DNS](https://www.digitalocean.com/community/tutorials/an-introduction-to-dns-terminology-components-and-concepts)
    * buy a domain from a registrar
    * [point to DigitalOcean nameservers from a domain name registrar](https://www.digitalocean.com/community/tutorials/how-to-point-to-digitalocean-nameservers-from-common-domain-registrars) in order to manage DNS records declaratively from the cluster
    * [add](https://www.digitalocean.com/docs/networking/dns/quickstart/#add-a-domain) a domain to your project from the control panel
4) create a [Personal Access Token](https://www.digitalocean.com/docs/api/create-personal-access-token)
5) apply the bootstrap chart
    ```bash
    make
    ```
6) [port-forward](https://github.com/edgelevel/gitops-k8s#bootstrap) ArgoCD (see step 3) and override these application parameters from the UI
    * `applications-do` > `digitalOceanToken` with the Personal Access Token to create a LoadBalancer
    * `applications-do` > `domain` e.g. `example.com`
    * `elasticsearch` > `volumeClaimTemplate.storageClassName` with `do-block-storage` specific for [DigitalOcean](https://www.digitalocean.com/docs/kubernetes/how-to/add-volumes/#define-the-persistent-volume-claim)
    * *TODO fix argocd secrets [issue](https://github.com/argoproj/argo-cd/issues/1786) to automate the steps above*
6) Sync all the applications from the UI manually

## Applications

Applications in this repository are defined in the parent [applications-do](applications-do/templates) chart and are logically split into folders which represent Kubernetes namespaces

**`ambassador`** namespace is dedicated for [Ambassador](https://www.getambassador.io) and defines
* an application with a service annotation to allow external-dns to automatically create DNS records and internally route all the requests
* [`ambassador-mapping`](charts/ambassador-mapping/templates) contains the definitions of all the routes in form of helm chart
    * `ambassador.example.com`
    * `kubernetes-dashboard.example.com`
    * `kube-ops-view.example.com`
    * `prometheus.example.com`
    * `alertmanager.example.com`
    * `grafana.example.com`
    * `elasticsearch.example.com`
    * `cerebro.example.com`
    * `kibana.example.com`
    * `bot.example.com`
    * *TODO* `argocd.example.com`

**`kube-do`** namespace is dedicated for system wide resources tightly coupled to DigitalOcean

* [`external-dns`](https://github.com/kubernetes-incubator/external-dns) synchronizes exposed Kubernetes Services and Ingresses with DNS providers

**`bot`** namespace is dedicated for a Scala pure FP [bot](https://github.com/niqdev/mobile-carrier-bot) to scrape the balance of mobile carriers

**Resources**

* [An Introduction to Managing DNS](https://www.digitalocean.com/community/tutorial_series/an-introduction-to-managing-dns)
* [Domains and DNS](https://www.digitalocean.com/docs/networking/dns)
* [An Introduction to the Kubernetes DNS Service](https://www.digitalocean.com/community/tutorials/an-introduction-to-the-kubernetes-dns-service)
* [How To Automatically Manage DNS Records From DigitalOcean Kubernetes Using ExternalDNS](https://www.digitalocean.com/community/tutorials/how-to-automatically-manage-dns-records-from-digitalocean-kubernetes-using-externaldns)
* [How to Manage CAA Records](https://www.digitalocean.com/docs/networking/dns/how-to/caa)
* [An Introduction to Let's Encrypt](https://www.digitalocean.com/community/tutorials/an-introduction-to-let-s-encrypt)
* [Setting Up a Domain with SSL on DigitalOcean Kubernetes using ExternalDNS and Helm](https://blog.andrewsomething.com/2019/04/04/external-dns-with-ssl-on-k8s)
* [Kubernetes Tutorial: Managing TLS Certificates with Ambassador](https://auth0.com/blog/kubernetes-tutorial-managing-tls-certificates-with-ambassador)
* [Kubernetes secrets](https://kubernetes.io/docs/concepts/configuration/secret)
* [Using Kubernetes Secrets](https://medium.com/platformer-blog/using-kubernetes-secrets-5e7530e0378a)
* [Kubernetes External Secrets](https://godaddy.github.io/2019/04/16/kubernetes-external-secrets)

TODO
* [ ] try to automate the bootstrap steps using the [API](https://developers.digitalocean.com/documentation/v2)
* [ ] expose argocd over http
* [ ] configure TLS/cert and authentication on ambassador for all services
