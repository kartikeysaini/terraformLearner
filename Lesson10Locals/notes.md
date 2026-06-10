# Terraform Locals

## Overview

Locals (or Local Values) are used to assign a value to a name within a Terraform configuration.

They help avoid repeating the same values multiple times and make the code more readable and maintainable.

Unlike variables, local values cannot be provided by the user at runtime. They are defined and calculated within the Terraform configuration itself.

---

## Why Use Locals?

Without locals, the same value may need to be repeated in multiple places.

Example:

```hcl
resource "aws_instance" "web" {
  tags = {
    Name        = "dev-web-server"
    Environment = "dev"
  }
}

resource "aws_instance" "app" {
  tags = {
    Name        = "dev-app-server"
    Environment = "dev"
  }
}
```

Notice that `"dev"` is repeated multiple times.

Using locals, we can define it once and reuse it everywhere.

---

## Defining Locals

```hcl
locals {
  environment = "dev"
}
```

---

## Using Locals

Local values are accessed using:

```hcl
local.<name>
```

Example:

```hcl
resource "aws_instance" "web" {
  tags = {
    Name        = "web-server"
    Environment = local.environment
  }
}

resource "aws_instance" "app" {
  tags = {
    Name        = "app-server"
    Environment = local.environment
  }
}
```

---

## Multiple Local Values

```hcl
locals {
  environment = "dev"
  owner       = "Kartikey"
  project     = "terraform-learning"
}
```

Usage:

```hcl
resource "aws_instance" "web" {

  tags = {
    Environment = local.environment
    Owner       = local.owner
    Project     = local.project
  }
}
```

---

## Locals with Expressions

Locals can also be computed using expressions.

Example:

```hcl
locals {
  instance_name = "${var.environment}-web-server"
}
```

Usage:

```hcl
resource "aws_instance" "web" {

  tags = {
    Name = local.instance_name
  }
}
```

If:

```hcl
environment = "dev"
```

Result:

```text
dev-web-server
```

---

## Locals with Objects

Locals can store complex data structures.

Example:

```hcl
locals {
  ec2_config = {
    instance_type = "t2.micro"
    volume_size   = 10
    volume_type   = "gp3"
  }
}
```

Usage:

```hcl
resource "aws_instance" "web" {

  instance_type = local.ec2_config.instance_type

  root_block_device {
    volume_size = local.ec2_config.volume_size
    volume_type = local.ec2_config.volume_type
  }
}
```

---

## Locals with Conditional Logic

Example:

```hcl
locals {
  instance_type = var.environment == "prod" ? "t3.medium" : "t2.micro"
}
```

Usage:

```hcl
resource "aws_instance" "web" {
  instance_type = local.instance_type
}
```

Result:

- Production → `t3.medium`
- Non-production → `t2.micro`

---

## Variables vs Locals

| Feature | Variables | Locals |
|----------|-----------|---------|
| User can provide value | Yes | No |
| Runtime input supported | Yes | No |
| Defined inside Terraform | Optional | Yes |
| Used for configuration inputs | Yes | No |
| Used for derived values | Limited | Yes |

---

## When to Use Variables

Use variables when:

- Users need to provide values.
- Values change between environments.
- Runtime customization is required.

Examples:

- AWS Region
- Instance Type
- Environment Name

---

## When to Use Locals

Use locals when:

- A value is repeated multiple times.
- You need calculated values.
- You want cleaner and more maintainable code.
- You want to centralize configuration values.

Examples:

- Naming conventions
- Common tags
- Derived configurations
- Environment-specific logic

---

## Example: Common Tags

Without locals:

```hcl
tags = {
  Environment = "dev"
  Project     = "terraform"
  Owner       = "Kartikey"
}
```

Repeated across multiple resources.

With locals:

```hcl
locals {
  common_tags = {
    Environment = "dev"
    Project     = "terraform"
    Owner       = "Kartikey"
  }
}
```

Usage:

```hcl
resource "aws_instance" "web" {
  tags = local.common_tags
}

resource "aws_s3_bucket" "data" {
  tags = local.common_tags
}
```

This follows the DRY (Don't Repeat Yourself) principle.

---

## Summary

- Locals are named values defined inside Terraform.
- They help reduce duplication and improve readability.
- Local values cannot be changed by users at runtime.
- Access locals using:

```hcl
local.<name>
```

- Locals can store:
  - Strings
  - Numbers
  - Lists
  - Maps
  - Objects
  - Expressions
  - Conditional logic

- Use variables for user inputs.
- Use locals for reusable and computed values within Terraform.