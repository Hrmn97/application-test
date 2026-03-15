terraform {
  required_version = ">=1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.30"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "terraform-stateless-prod"
    key    = "network/terraform.tfstate"
    region = "us-west-2"
  }
}