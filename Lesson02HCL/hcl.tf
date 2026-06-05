terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

# Resource is managed by us using terraform

resource "aws_s3_bucket" "myS3Buck01" {

    bucket = var.myVar1 # accesssing the variable 
  
}

# data block gives us the ability to use the infra which is not managed by terraform

data "aws_s3_bucket" "myManualBuck"{

    bucket = "myFirstManualBucket"
}

variable "myVar1" {

    type = string
    description = "My var used to set bucket name"
    default = "myBuckName"
  
}

# Output allow us to output in the console the value we want to see when we run terraform apply

output "bucket_id" {
  value = aws_s3_bucket.myS3Buck01.id
}

# locals are the local variables

locals {
  local_ex = "this is a local variable"
}

# below it shows how locals are access using local

output "localExample01" {
  value = local.local_ex
}


# module -> piece of reusable code

module "myFirstModule" {
  source = "./module-example"
}




