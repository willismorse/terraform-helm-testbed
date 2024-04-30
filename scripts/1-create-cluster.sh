source ./scripts/.env

# Uses option env var
# K3S_VERSION_TAG
#
# See below for available versions
# https://hub.docker.com/r/rancher/k3s/tags


echo "Deleting any existing cluster"
source ./scripts/delete-cluster.sh

echo "Creating a new cluster"


echo "Using K3s version: ${K3S_VERSION_TAG}"


k3d cluster create "$CLUSTER_NAME"              \
--image rancher/k3s:${K3S_VERSION_TAG}          \
--api-port ${CLUSTER_PORT_API}                  \
-p "$CLUSTER_PORT_HTTP:80@loadbalancer"         \
-p "$CLUSTER_PORT_HTTPS:443@loadbalancer"       \
--k3s-arg '--disable=traefik@server:*'          \
--agents 2                                      
