source ./scripts/.env

# This script will pull all local file-based charts that are contained in the project's topleve; ./services directory
# The list of remote charts is contained within the chart_versions_local array
source ./scripts/fetch-charts-local.sh


# This script will pull charts from a remote Helm registry.
# The list of remote charts is contained within the chart_versions_helm_registry array
# Provide the registry prefix in an environment variable named HELM_REGISTRY_ALIAS_ENV_VAR
# These scripts assume the host machine's helm CLI has been configured with URL and authn for this registry

# source ./scripts/fetch-charts-helm-registry.sh



