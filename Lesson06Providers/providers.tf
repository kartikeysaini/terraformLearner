terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = "ap-south-1"
  
}

provider "aws" {
    region = "eu-west-1"
    alias = "eu"
}

resource "aws_s3_bucket" "buck01Default" {
    bucket = "buck01default-11223344"
  
}

resource "aws_s3_bucket" "buck02EU" {
    bucket = "buck02eu-00998877"
    provider = aws.eu  
  
}

