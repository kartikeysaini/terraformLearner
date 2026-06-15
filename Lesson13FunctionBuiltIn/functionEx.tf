locals {
  name = "kartikey"
  age = 29
}

output "example1" {
    value = upper(local.name)
  
}

output "example2" {

    value = pow(local.age,2)
  
}

output "example3" {
  value = file("${path.module}/users.yml")
}

output "example4" {
  value = yamldecode(file("${path.module}/users.yml")).users[*].name
}