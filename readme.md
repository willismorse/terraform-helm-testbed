# Introduction

A local testbed for exploring the behavior and interactions of Kubernetes, Terraform, and the Hashicorp Helm Provider.

This repo manages a local k3d Kubernetes cluster, provides a directory to work with file-based service Helm charts, and sets up a basic Terraform deployment project which uses the Helm provider to perform Helm chart deployment into the k3d cluster.

The k3d cluster will be available on the host machine at http://terraform-helm-testbed.local:10080 (sorry, no https yet)



# Important Files and Directories

* `scripts/.env` contains various configurations needed by the scripts. Most entries can be left as is, but these may be interesting: 
    * `K3S_VERSION_TAG` selects the version of Kubernetes k3s that is used in k3d. This must be one of the [official k3s releases](https://hub.docker.com/r/rancher/k3s/tags)  
    * `KUBE_CONFIG_PATH` value defaults to standard location for kube configuration
    * Variables for the components of the cluster host url, in case there are conflicts on your machine
* `terraform/`  contains the Terraform project. Ephemeral terraform data  (initialization data and state) are also stored here and have been added to `.gitignore`
* `terraform/modules/helm/chart_versions.tf` contains two lists of chart versions: 
  * one for file-based charts coming from the `services/` directory
  * one for charts sourced from a Helm registry (note that support for this option is currently disabled until I get this debugged)

* `services/` contains local file-based charts that will be automatically made available to the Helm provider. Includes an example service which provides basic in-cluster DNS utilities, sourcing a public Dockerhub image. Any charts that you add in this folder must conform to the same containing directory structure as the example service.





# About kube configuration

**Caveat emptor**: The `k3d CLI` tool will automatically add/remove an entry for the k3d cluster into your kube configuration as the cluster is created or deleted. This generally works well if you have a single monolithic configuration file in the standard location. 





# Performing deployments

Perform these scripts in order:

```
# Create a local k3d cluster
./scripts/1-create-cluster.sh 

# Copy external charts into the `.terraform/modules/helm/charts` directory for use by the Helm provider. In the future, this will also fetch from remote Helm registries
./scripts/2-fetch-charts.sh 

# Perform a `terraform init`
./scripts/3-init-terraform.sh 

# Perform a `terraform plan`
./scripts/4-plan-terraform.sh 

# Perform a `terraform apply`, deploying the charts to the local k3d cluster
./scripts/5-apply-terraform.sh
```





# Re-baselining and teardown 

Perform these scripts in any order, as needed:

```
# Remove any charts that have been copied into ./terraform/modules/helm/charts
scripts/clean-charts.sh

# Remove any persisted terraform initialization and state
scripts/clean-terraform.sh

# Tear down the local k3d cluster
scripts/delete-cluster.sh
```





# Required local tools

- [k3d CLI](https://k3d.io/v5.6.3/#installation)
- [helm CLI](https://helm.sh/docs/helm/helm_install/)
- [kubectl CLI](https://kubernetes.io/docs/tasks/tools/)
- [terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)





# Optional local tools:

- [tfenv CLI](https://github.com/tfutils/tfenv#installation) (or equivalent) to support switching between versions of local terraform cli