locals {
  ami_ids = {
    ubuntu = data.aws_ami.ubuntu.id
    # nginx  = data.aws_ami.nginx.id
  }
}


data "aws_ami" "ubuntu" {

  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

# data "aws_ami" "nginx" {
#   # could not find the ami as the data is not available

#   filter {
#     name   = "name"
#     values = ["bitnami-nginx-1.*.*-*-linux-debian-12-x86_64-hvm-ebs-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

# }

resource "aws_instance" "from_list" {
  count         = length(var.ec2-instance-config-list)
  ami           = local.ami_ids[var.ec2-instance-config-list[count.index].ami]
  instance_type = var.ec2-instance-config-list[count.index].instance_type

  subnet_id = aws_subnet.main[count.index % length(aws_subnet.main)].id

  tags = {
    Name      = "${local.Name}-${count.index}"
    ManagedBy = local.ManagedBy
  }

}

# resource "aws_instance" "from_count" {
#   count         = var.ec2-instance-count
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t2.micro"

#   subnet_id = aws_subnet.main[count.index % length(aws_subnet.main)].id

#   tags = {
#     Name      = "${local.Name}-${count.index}"
#     ManagedBy = local.ManagedBy
#   }

# }