# Terraform Outputs

## Overview

Outputs are used to display information from Terraform-managed resources after infrastructure has been created or updated.

They allow users to easily access important values such as resource IDs, IP addresses, DNS names, and other attributes without manually looking them up in the cloud provider.

---

## Why Use Outputs?

After creating infrastructure, we often need information about the resources that were created.

Examples:

- EC2 Instance ID
- EC2 Public IP
- EC2 Private IP
- VPC ID
- Subnet ID
- Load Balancer DNS Name

Instead of searching for these values in AWS, Terraform can display them automatically using outputs.

---

## Creating an Output

Example:

```hcl
output "instance_id" {
  value = aws_instance.web.id
}
```

After running:

```bash
terraform apply
```

Terraform displays:

```text
Outputs:

instance_id = "i-0123456789abcdef"
```

---

## Outputting Multiple Values

```hcl
output "instance_id" {
  value = aws_instance.web.id
}

output "public_ip" {
  value = aws_instance.web.public_ip
}

output "private_ip" {
  value = aws_instance.web.private_ip
}
```

Result:

```text
Outputs:

instance_id = "i-0123456789abcdef"
public_ip   = "13.232.xx.xx"
private_ip  = "172.31.xx.xx"
```

---

## Viewing Outputs

### View All Outputs

```bash
terraform output
```

Example:

```text
instance_id = "i-0123456789abcdef"
public_ip   = "13.232.xx.xx"
private_ip  = "172.31.xx.xx"
```

---

### View a Specific Output

```bash
terraform output public_ip
```

Result:

```text
13.232.xx.xx
```

---

## Outputting Values from Variables

Outputs are not limited to resource attributes.

They can also display variable values.

Example:

```hcl
output "selected_region" {
  value = var.aws_region
}
```

Result:

```text
selected_region = "ap-south-1"
```

---

## Outputting Local Values

Outputs can also display local values.

Example:

```hcl
locals {
  environment = "dev"
}

output "environment_name" {
  value = local.environment
}
```

Result:

```text
environment_name = "dev"
```

---

## Sensitive Outputs

Sometimes outputs may contain sensitive information such as:

- Passwords
- Database connection strings
- API Keys
- Secrets

Terraform allows outputs to be marked as sensitive.

Example:

```hcl
output "db_password" {
  value     = var.db_password
  sensitive = true
}
```

Result:

```text
db_password = <sensitive>
```

This prevents the value from being displayed in the Terraform output.

---

## Outputs and State Files

Even when an output is marked as sensitive:

```hcl
sensitive = true
```

the value is still stored in the Terraform state file.

Sensitive outputs only hide the value from terminal output; they do not encrypt it.

---

## Outputs in Modules

Outputs are commonly used to expose values from a child module to a parent module.

### Child Module

```hcl
output "instance_id" {
  value = aws_instance.web.id
}
```

### Parent Module

```hcl
module "ec2" {
  source = "./modules/ec2"
}

output "web_instance_id" {
  value = module.ec2.instance_id
}
```

This allows modules to share information with other parts of the Terraform configuration.

---

## Common Output Examples

### EC2 Public IP

```hcl
output "public_ip" {
  value = aws_instance.web.public_ip
}
```

---

### EC2 Instance ID

```hcl
output "instance_id" {
  value = aws_instance.web.id
}
```

---

### VPC ID

```hcl
output "vpc_id" {
  value = aws_vpc.main.id
}
```

---

### Load Balancer DNS Name

```hcl
output "lb_dns_name" {
  value = aws_lb.app_lb.dns_name
}
```

---

## Best Practices

- Output only values that are useful to users.
- Mark secrets as sensitive.
- Use descriptive output names.
- Avoid exposing unnecessary internal details.
- Use outputs to share information between modules.

---

## Outputs vs Variables

| Feature | Variables | Outputs |
|----------|-----------|----------|
| Used to provide input | Yes | No |
| Used to display values | No | Yes |
| Value supplied by user | Yes | No |
| Can reference resources | No | Yes |
| Commonly used with modules | Yes | Yes |

---

## Summary

- Outputs are used to display values after Terraform creates or updates infrastructure.
- They provide quick access to resource attributes such as IDs, IP addresses, and DNS names.
- Outputs can reference:
  - Resources
  - Variables
  - Locals
  - Module outputs
- View outputs using:

```bash
terraform output
```

- View a specific output using:

```bash
terraform output <output_name>
```

- Sensitive outputs hide values from terminal output but are still stored in the Terraform state file.
- Outputs are heavily used when working with Terraform modules.