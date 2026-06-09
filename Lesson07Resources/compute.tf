resource "aws_instance" "dev-env-01" {

  ami                         = "ami-053d8044b1108bd96"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet-dev.id
  vpc_security_group_ids = [ aws_security_group.public_traffic.id ]
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }
  tags = merge(local.common_tags, {
    Name : "Lesson07-EC2"
  })

  lifecycle {
    create_before_destroy = true
    ignore_changes = [ tags ]
  }

}

resource "aws_security_group" "public_traffic" {
    description = "Security group for allowing http on port 80 and 443"
    name = "public-http-traffic"
    vpc_id = aws_vpc.vpc-dev.id  
    tags = merge(local.common_tags, {
    Name : "Lesson07-SG"
  })
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.public_traffic.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"

}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.public_traffic.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"

}



