variable "subnet-count" {
  type    = number
  default = 2
}

variable "ec2-instance-count" {
  type    = number
  default = 1

}

variable "ec2-instance-config-list" {
  type = list(object({
    instance_type = string
    ami           = string
  }))

  validation {
    condition     = alltrue([for config in var.ec2-instance-config-list : contains(["t2.micro"], config.instance_type)])
    error_message = "Only Allows t2.micro"
  }

  validation {
    condition     = alltrue([for config in var.ec2-instance-config-list : contains(["nginx","ubuntu"], config.ami)])
    error_message = "Only Allows Ubuntu and Nginx"
  }

}