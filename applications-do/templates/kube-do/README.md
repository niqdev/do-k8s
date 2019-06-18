## kube-do

1) [An Introduction to DNS Terminology, Components, and Concepts](https://www.digitalocean.com/community/tutorials/an-introduction-to-dns-terminology-components-and-concepts)
2) [How To Point to DigitalOcean Nameservers From Common Domain Registrars](https://www.digitalocean.com/community/tutorials/how-to-point-to-digitalocean-nameservers-from-common-domain-registrars)
3) [How to Create a Personal Access Token](https://www.digitalocean.com/docs/api/create-personal-access-token)
4) `external-dns`
    * [Setting up ExternalDNS for Services on DigitalOcean](https://github.com/kubernetes-incubator/external-dns/blob/master/docs/tutorials/digitalocean.md)
    * [Helm chart](https://github.com/helm/charts/tree/master/stable/external-dns)

```bash
cd applications-do/

helm template . \
  --values values.yaml \
  --set externalDns.domain=mydomain.com \
  --set externalDns.digitalOceanToken=XYZ
```

**Resources**

* [An Introduction to Managing DNS](https://www.digitalocean.com/community/tutorial_series/an-introduction-to-managing-dns)
* [Domains and DNS](https://www.digitalocean.com/docs/networking/dns)
* [An Introduction to the Kubernetes DNS Service](https://www.digitalocean.com/community/tutorials/an-introduction-to-the-kubernetes-dns-service)

* [How to Manage CAA Records](https://www.digitalocean.com/docs/networking/dns/how-to/caa)
* [An Introduction to Let's Encrypt](https://www.digitalocean.com/community/tutorials/an-introduction-to-let-s-encrypt)
* [Setting Up a Domain with SSL on DigitalOcean Kubernetes using ExternalDNS and Helm](https://blog.andrewsomething.com/2019/04/04/external-dns-with-ssl-on-k8s)

* [Kubernetes secrets](https://kubernetes.io/docs/concepts/configuration/secret)