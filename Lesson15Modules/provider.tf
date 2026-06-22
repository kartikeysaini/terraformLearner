terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
        version = "~> 5.0"
        source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "south-ap-1"
}