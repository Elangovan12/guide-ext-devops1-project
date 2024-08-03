# Terraform Block
terraform {
  required_version = "~> 1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.61"
    }
  }
}

# Provider Block
provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = ["$HOME/.aws/credentials"]
  profile                  = "cloudstudio"
}

# Create Terraform Backend in S3 and dynamoDB
terraform {
  backend "s3" {
    bucket                   = "terra-devops1-state-9998"
    key                      = "remote/terraform.tfstate"
    region                   = "ap-south-1"
    dynamodb_table           = "terraform_state"
    shared_credentials_files = ["$HOME/.aws/credentials"]
    profile                  = "cloudstudio"

  }
}
