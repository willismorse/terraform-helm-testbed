source ./scripts/.env

rm -rf ./terraform/.terraform

rm -rf ./terraform/terraform.tfstate

rm -rf ./terraform/terraform.tfstate.backup
source ./scripts/clean-charts.sh