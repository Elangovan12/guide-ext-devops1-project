# Terraform Block
terraform {
  required_version = "~> 1.4"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.2"
    }
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "default"
}

# Create Terraform Backend in S3 and dynamoDB
terraform {
  backend "s3" {
    bucket         = "terra-k8swrkspce-state-50987"
    key            = "remote/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "dynamodb-state-locking"
  }
}