
terraform init
terraform plan -var-file="../environments/dev/variable.tfvars"
terraform apply -var-file="../environments/dev/variable.tfvars"

terraform destroy -var-file="../environments/dev/variable.tfvars"a