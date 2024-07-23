#terraform {
#  backend "s3" {
#    # These values are placeholders and will be overridden by the values in backend.tfvars
#    bucket         = "PLACEHOLDER"
#    key            = "PLACEHOLDER"
#    region         = "PLACEHOLDER"
#    dynamodb_table = "PLACEHOLDER"
#    encrypt        = true
#  }
#
#}

provider "aws" {
  region = var.region
}
