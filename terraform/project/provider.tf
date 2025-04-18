provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "aws-terraformix"
    key    = "back/terraform.tfstate"
    region = "eu-central-1"
  }
}
