locals {
  ManagedBy = "Terraform"
  Name      = "Lesson14MultiResource"
}


resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name      = local.Name
    ManagedBy = local.ManagedBy
  }
}

resource "aws_subnet" "main" {
  count      = var.subnet-count
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.${count.index}.0/24"

  tags = {
    Name      = "${local.Name}-${count.index}"
    ManagedBy = local.ManagedBy
  }
}