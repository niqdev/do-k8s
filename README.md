# do-k8s

```bash
# skeleton (first time) + cleanup
helm create bootstrap/

cd bootstrap/
# add repository
helm repo add edgelevel https://edgelevel.github.io/gitops-k8s
# download seed chart
helm dependency update

# bootstrap cluster
./bootstrap-unofficial/apply.sh
```
