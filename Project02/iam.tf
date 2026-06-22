locals {
  usersData = yamldecode(file("${path.module}/users.yml"))
}



resource "aws_iam_user" "users" {

  for_each = toset(local.usersData.users[*].username)
  name     = each.value


  tags = {
    Name      = "Project02"
    ManagedBy = "Terraform"
  }

}

resource "aws_iam_user_login_profile" "users" {
  for_each        = aws_iam_user.users
  user            = each.value.name
  password_length = 8

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key
    ]
  }
}

output "passwords" {
  sensitive = true
  value = {
    for user, user_login in aws_iam_user_login_profile.users : user => user_login.password
  }
}