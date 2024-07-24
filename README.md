# Run in resource folder
terraform init
terraform plan -var-file="../environments/dev/variable.tfvars"
terraform apply -var-file="../environments/dev/variable.tfvars"

terraform destroy -var-file="../environments/dev/variable.tfvars"


# Run In environments\dev folder
terragrunt init
terragrunt plan
terragrunt apply 

terragrunt destroy