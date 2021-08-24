# Author: Josh Bolling
# Module name: lamp-stack-ansible
# Date: 8/13/21

# Declare AWS terraform provisioner

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.52.0"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region

}