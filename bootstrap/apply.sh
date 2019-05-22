#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

##############################

# add seed helm repository
helm repo add edgelevel https://edgelevel.github.io/gitops-k8s

# download seed chart locally
helm dependency update

# apply chart
helm template --values values.yaml . | kubectl apply -n argocd -f -
