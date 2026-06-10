In this lesson we learnt about the different types of variables and how we can add validation on the input of the variable values

validations allow us to allow certain values only which are specified


for example

for a variable like instance type, if we want to restrict it to certain values 

### we can add validation like below

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"

  validation {
    condition     = var.ec2_instance_type == "t2.micro"
    error_message = "Only supports t2.micro"
  }
}

### better way using contains function for multiple values

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"

  validation {
    condition     = contains(["t2.micro","t3.micro"],var.ec2_instance_type)
    error_message = "Only supports t2.micro"
  }
}