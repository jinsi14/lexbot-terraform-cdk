
terraform init -backend-config=environments/dev/backend.tfvars
terraform plan -var-file="environments/dev/variable.tfvars"
terraform apply -var-file="environments/dev/variable.tfvars"

terraform destroy -var-file="environments/dev/variable.tfvars"