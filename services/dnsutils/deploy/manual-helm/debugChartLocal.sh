#!/bin/bash
rm ./deploy/manual-helm/generated-chart.yaml
source ./deploy/manual-helm/helm-params



helm install                                                    \
  "dnsutils-$NAMESPACE"                   \
  ./deploy/helm              \
  --version "$VERSION"                                          \
  --namespace "$NAMESPACE"                                      \
  --dry-run --debug  > "./deploy/manual-helm/generated-chart.yaml"

