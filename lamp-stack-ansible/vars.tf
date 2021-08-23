# Author: Josh Bolling
# Module name: lamp-stack-ansible
# Date: 8/13/21

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "region" {
        default = "us-east-1"
}
variable "vpc_subnet" {
    
    type = string
    default = "10.0.0.0/16"
}

