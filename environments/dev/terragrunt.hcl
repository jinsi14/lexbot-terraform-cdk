
terraform {
  source = "../../resources"
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "digi-test-bucket-2306"
    key            = "env/dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "lex-bot-test-dev"
  }
}

inputs = {
  region                      = "us-east-1"
  prefix_company              = "digi"
  lob                         = "internal"
  prefix_region               = "use1"
  env                         = "dev"
  repo_url                    = "https://github.com/jinsi14/lexbot-terraform-cdk"
}
