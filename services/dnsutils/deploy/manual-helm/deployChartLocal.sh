#!/bin/bash

source ./deploy/manual-helm/helm-params



helm upgrade                                                    \
  "dnsutils-$NAMESPACE"              \
  ./deploy/helm      \
  --version "$VERSION"                                          \
  --namespace "$NAMESPACE"                                      \
  --install                                                     \
  --force                                                       \
