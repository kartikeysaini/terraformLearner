locals {
  names_from_splat = var.objects_list[*].firstname
}

output "firstNamesSplat" {
  value = local.names_from_splat
}