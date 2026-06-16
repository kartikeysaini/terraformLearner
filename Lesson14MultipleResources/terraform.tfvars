subnet-count       = 2
ec2-instance-count = 0
ec2-instance-config-list = [{
  instance_type = "t2.micro"
  ami           = "ubuntu"
  }
  # {
  #   instance_type = "t2.micro"
  #   ami           = "nginx"
  # }
]
ec2_instance_config_map = {
  ubuntu_1 = {
    instance_type = "t2.micro",
    ami           = "ubuntu"
  }

  # nginx_1 = {
  #   instance_type = "t2.micro",
  #   ami           = "nginx"
  # }
}