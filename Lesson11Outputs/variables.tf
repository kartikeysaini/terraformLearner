variable "ec2_instance_type" {
  type = string

  validation {
    condition     = var.ec2_instance_type == "t2.micro"
    error_message = "Only accepts t2.micro"
  }
}


variable "ec2_volume_config" {
  type = object({
    size = number
    type = string
  })

  description = "The size and type of the volume for EC2 instance"
}

variable "additional_tags" {
  type = map(string)
  default = {}
}