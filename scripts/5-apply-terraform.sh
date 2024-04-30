source ./scripts/.env

pushd ./terraform
terraform apply -auto-approve
popd