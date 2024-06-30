terraform {
  backend "s3" {
    bucket = "brstworkshop1"
    key    = "rst/iac"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.46.0"
    }
  }

  required_version = "~> 1.7"
}

variable "region" {
  type        = string
  description = "AWS region for all cloud resources"
}

data "terraform_remote_state" "msbet" {
  backend = "s3"

  config = {
    bucket = "brstworkshop1"
    key    = "env:/workshop1-pro-msbet/rst/iac"
    region = var.region
  }
}

output "apigateway_endpoint_msbet" {
  value = data.terraform_remote_state.msbet.outputs.apigateway_endpoint
}
