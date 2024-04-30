#!/bin/bash

source ./deploy/manual-helm/helm-params

helm lint \
  ./deploy/helm/charts/dnsutils