terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "5.12.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }

  }
}

provider "aws" {
  # Configuration options
  region = local.aws_region
}

provider "random" {
  # Configuration options
}