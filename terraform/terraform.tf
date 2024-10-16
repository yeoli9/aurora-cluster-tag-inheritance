terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.61.0"
    }
  }
  # set your backend
  backend "s3" {
  }
}

# Configure the AWS Provider
provider "aws" {
}
