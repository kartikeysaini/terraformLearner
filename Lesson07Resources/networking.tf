locals {
  common_tags = {
    ManagedBy = "Terraform"
    Project   = "MyLearningProject"
  }
}


resource "aws_vpc" "vpc-dev" {
  cidr_block = "10.0.0.0/16"

  tags = merge(local.common_tags, {
    Name : "Lesson07-vpc"
  })

}

resource "aws_subnet" "subnet-dev" {

  vpc_id     = aws_vpc.vpc-dev.id
  cidr_block = "10.0.0.0/24"

  tags = merge(local.common_tags, {
    Name : "Lesson07-subnet"
  })

}


resource "aws_internet_gateway" "igw-dev" {
  vpc_id = aws_vpc.vpc-dev.id
  tags = merge(local.common_tags, {
    Name : "Lesson07-igw"
  })
}

resource "aws_route_table" "rtd-dev" {

  vpc_id = aws_vpc.vpc-dev.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-dev.id
  }
  tags = merge(local.common_tags, {
    Name : "Lesson07-rtd"
  })

}

resource "aws_route_table_association" "rtdassoc-dev" {
  subnet_id      = aws_subnet.subnet-dev.id
  route_table_id = aws_route_table.rtd-dev.id


}