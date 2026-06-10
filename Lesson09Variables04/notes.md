# Terraform tfvars Files

## Overview

In this lesson, we learned about Terraform Variable Definition Files (`.tfvars`).

The `variables.tf` file defines the variables that Terraform expects, while `.tfvars` files provide values for those variables.

---

## Example Variable Definition

```hcl
variable "aws_region" {
  type = string
}
```

## Example tfvars File

```hcl
aws_region = "ap-south-1"
```

---

## Benefits

- Keeps configuration separate from code
- Avoids hardcoded values
- Makes deployments repeatable
- Supports multiple environments

---

## Environment-Specific tfvars Files

### dev.tfvars

```hcl
aws_region   = "ap-south-1"
instance_type = "t2.micro"
```

### prod.tfvars

```hcl
aws_region   = "us-east-1"
instance_type = "t3.medium"
```

---

## Using a Specific tfvars File

```bash
terraform plan -var-file="dev.tfvars"
```

```bash
terraform apply -var-file="prod.tfvars"
```

---

## Summary

- `variables.tf` defines variables.
- `.tfvars` files provide values.
- `terraform.tfvars` is loaded automatically.
- Custom tfvars files can be specified with `-var-file`.
- Different tfvars files can be used for different environments.