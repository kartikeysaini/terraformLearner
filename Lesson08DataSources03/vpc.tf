data "aws_vpc" "prod-vpc" {
  tags = {
    Env = "Prod"
  }
}

output "vpc-prod-id" {
  value = data.aws_vpc.prod-vpc.id
}