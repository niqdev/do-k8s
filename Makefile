.DEFAULT_GOAL := all

KUBECTL := $(shell command -v kubectl 2> /dev/null)
HELM := $(shell command -v helm 2> /dev/null)
ARGOCD := $(shell command -v argocd 2> /dev/null)

.PHONY: requirements
requirements:
ifndef KUBECTL
	$(error "kubectl" not found)
endif
ifndef HELM
	$(error "helm" not found)
endif
ifndef ARGOCD
	$(error "argocd" not found)
endif

.PHONY: bootstrap
bootstrap:
	./bootstrap/apply.sh

.PHONY: all
all: requirements bootstrap
