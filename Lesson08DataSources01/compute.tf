

data "aws_ami" "ubuntu" {

    most_recent = true
    owners = [ "099720109477" ]

    filter {
      name = "name"
      values = [ "ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*" ]
    }

    filter {
      name = "virtualization-type"
      values = [ "hvm" ]
    }
  
}

output "test" {
  value = data.aws_ami.ubuntu
}

resource "aws_instance" "dev-env-01" {

  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }
  

}
