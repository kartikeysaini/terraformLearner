variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"

  validation {
    condition     = var.ec2_instance_type == "t2.micro"
    error_message = "Only supports t2.micro"
  }
}

variable "ec2_volume_size" {
  type    = number
  default = 10
}

variable "ec2_volume_type" {
  type    = string
  default = "gp2"
}