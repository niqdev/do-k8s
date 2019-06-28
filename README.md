# do-k8s

[![Build Status][travis-image]][travis-url]

[travis-image]: https://travis-ci.org/niqdev/do-k8s.svg?branch=master
[travis-url]: https://travis-ci.org/niqdev/do-k8s

This cluster definition is based on the common infrastructure for Continuos Deployment and Observability described in [edgelevel/gitops-k8s](https://github.com/edgelevel/gitops-k8s) and is customized for DigitalOcean

## Bootstrap

The [bootstrap](bootstrap) chart has two main purposes:
* import the [`seed`](https://github.com/edgelevel/gitops-k8s/tree/master/charts/seed) chart to reuse and extend the common infrastracture
* create an [Application of Applications](https://argoproj.github.io/argo-cd/operator-manual/cluster-bootstrapping/#application-of-applications-pattern) defined in this repository

1) [Create](https://github.com/edgelevel/gitops-k8s#prerequisites) a Kubernetes cluster on [DigitalOcean](https://www.digitalocean.com/docs/kubernetes)
2) [Add](https://www.digitalocean.com/docs/networking/dns/quickstart/#add-a-domain) a domain e.g. `example.com` from the control panel
3) Bootstrap the cluster
    ```bash
    make
    ```
4) Port-forward ArgoCD and override these application parameters from the UI
    * `applications-do` > `digitalOceanToken` required to create a LoadBalancer: see [How to Create a Personal Access Token](https://www.digitalocean.com/docs/api/create-personal-access-token)
    * `applications-do` > `domain` e.g. `example.com`
    * `fluent-bit` > `storageClassName`: `do-block-storage`
    * *TODO fix argocd secrets [issue](https://github.com/argoproj/argo-cd/issues/1786)*
5) Sync all the applications from the UI manually

---

## Applications

Applications in this repository are defined in the parent [applications-do](applications-do/templates) chart and are logically split into folders which represent Kubernetes namespaces

**`ambassador`**

**`bot`**

**`kube-do`**

## Charts

**`ambassador-mapping`**

* `ambassador.example.com`
* `kubernetes-dashboard.example.com`
* `kube-ops-view.example.com`
* `prometheus.example.com`
* `alertmanager.example.com`
* `grafana.example.com`
* *TODO* `elasticsearch.example.com`
* *TODO* `cerebro.example.com`
* *TODO* `kibana.example.com`
* `bot.example.com`
* *TODO* `argocd.example.com`

TODO
* [ ] try to automate the bootstrap steps using the [API](https://developers.digitalocean.com/documentation/v2)
* [ ] add EFK ambassador mappings
* [ ] serve argocd over http
* [ ] configure TLS/cert on ambassador for all services
* [ ] update docs: namespace/service
