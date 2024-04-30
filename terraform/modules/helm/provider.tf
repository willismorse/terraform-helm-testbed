

provider "helm" {
  // This resolves an issue where terraform does not update releases when
  // values change.  The trade-off is that the entire manifest is processed.
  // There is an issue logged with the helm provider: 
  // https://github.com/hashicorp/terraform-provider-helm/issues/346
  # experiments {
  #   manifest = true
  # }
}
