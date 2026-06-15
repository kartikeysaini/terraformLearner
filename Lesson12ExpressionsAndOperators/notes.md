# Terraform Expressions, Operators, For Loops, Maps, Objects, and Splat Expressions

## Overview

Terraform provides expressions that allow us to perform calculations, comparisons, conditional logic, and transformations on data structures such as lists, maps, and objects.

These features help create dynamic and reusable infrastructure configurations.

---

# Terraform Operators

Operators are used to perform calculations and comparisons within Terraform expressions.

---

## Arithmetic Operators

Used for mathematical calculations.

| Operator | Description |
|-----------|-------------|
| `+` | Addition |
| `-` | Subtraction |
| `*` | Multiplication |
| `/` | Division |
| `%` | Modulus (remainder) |

Example:

```hcl
locals {
  total_storage = 10 + 20
}
```

Result:

```text
30
```

---

## Comparison Operators

Used to compare values.

| Operator | Description |
|-----------|-------------|
| `==` | Equal to |
| `!=` | Not equal to |
| `>` | Greater than |
| `<` | Less than |
| `>=` | Greater than or equal to |
| `<=` | Less than or equal to |

Example:

```hcl
locals {
  is_production = var.environment == "prod"
}
```

Result:

```text
true
```

---

## Logical Operators

Used to combine conditions.

| Operator | Description |
|-----------|-------------|
| `&&` | AND |
| `||` | OR |
| `!` | NOT |

Example:

```hcl
locals {
  allow_deployment = var.environment == "prod" && var.enable_deployment
}
```

---

## Conditional Expressions

Terraform supports ternary operators.

Syntax:

```hcl
condition ? true_value : false_value
```

Example:

```hcl
locals {
  instance_type = var.environment == "prod" ? "t3.medium" : "t2.micro"
}
```

Result:

```text
prod     → t3.medium
non-prod → t2.micro
```

---

# For Expressions

Terraform supports looping over collections such as:

- Lists
- Sets
- Maps
- Objects

---

## Looping Through a List

Example:

```hcl
locals {
  instance_names = ["web", "app", "db"]

  upper_names = [
    for name in local.instance_names : upper(name)
  ]
}
```

Result:

```text
[
  "WEB",
  "APP",
  "DB"
]
```

---

## Looping Through a Map

Example:

```hcl
locals {
  tags = {
    Environment = "Dev"
    Project     = "Terraform"
  }

  formatted_tags = [
    for key, value in local.tags :
    "${key}=${value}"
  ]
}
```

Result:

```text
[
  "Environment=Dev",
  "Project=Terraform"
]
```

---

## Filtering with For Expressions

Example:

```hcl
locals {
  numbers = [1, 2, 3, 4, 5]

  even_numbers = [
    for num in local.numbers : num
    if num % 2 == 0
  ]
}
```

Result:

```text
[
  2,
  4
]
```

---

# Objects vs Maps in For Loops

Objects and maps look similar but behave differently.

---

## Object Example

```hcl
locals {
  server = {
    name = "web-server"
    size = "t2.micro"
  }
}
```

Loop:

```hcl
[
  for key, value in local.server :
  "${key}=${value}"
]
```

Result:

```text
[
  "name=web-server",
  "size=t2.micro"
]
```

---

## Map Example

```hcl
locals {
  regions = {
    dev  = "ap-south-1"
    prod = "us-east-1"
  }
}
```

Loop:

```hcl
[
  for env, region in local.regions :
  "${env}:${region}"
]
```

Result:

```text
[
  "dev:ap-south-1",
  "prod:us-east-1"
]
```

---

## Difference Between Objects and Maps

| Feature | Object | Map |
|----------|---------|---------|
| Fixed Structure | Yes | No |
| Keys Known in Advance | Yes | No |
| Strong Validation | Yes | Limited |
| Dynamic Keys | No | Yes |

Objects are used for structured data.

Maps are used for dynamic key-value pairs.

---

# Converting Maps to Lists

Terraform provides functions to extract keys and values from maps.

---

## Getting Keys

```hcl
locals {
  regions = {
    dev  = "ap-south-1"
    prod = "us-east-1"
  }

  region_names = keys(local.regions)
}
```

Result:

```text
[
  "dev",
  "prod"
]
```

---

## Getting Values

```hcl
locals {
  region_values = values(local.regions)
}
```

Result:

```text
[
  "ap-south-1",
  "us-east-1"
]
```

---

# Converting Lists to Maps

Example:

```hcl
locals {
  environments = ["dev", "prod"]

  env_map = {
    for env in local.environments :
    env => upper(env)
  }
}
```

Result:

```text
{
  dev  = "DEV"
  prod = "PROD"
}
```

---

# Splat Expressions

A splat expression is a shortcut for extracting a specific attribute from every element in a list.

It reduces the need for explicit for loops.

---

## Without Splat

```hcl
[
  for instance in aws_instance.web :
  instance.id
]
```

---

## With Splat

```hcl
aws_instance.web[*].id
```

Result:

```text
[
  "i-12345",
  "i-67890"
]
```

Both expressions return the same result.

---

## Common Splat Examples

### Instance IDs

```hcl
aws_instance.web[*].id
```

---

### Public IPs

```hcl
aws_instance.web[*].public_ip
```

---

### Private IPs

```hcl
aws_instance.web[*].private_ip
```

---

# Limitation of Splat Expressions

Splat expressions only work with:

- Lists
- Tuples
- Resources created using `count`

They do not work directly with maps.

Example:

```hcl
resource "aws_instance" "web" {
  for_each = var.instances
}
```

This will not work:

```hcl
aws_instance.web[*].id
```

Because `for_each` creates a map of resources.

Instead, use a for expression:

```hcl
[
  for instance in aws_instance.web :
  instance.id
]
```

or

```hcl
{
  for key, instance in aws_instance.web :
  key => instance.id
}
```

---

# Splat vs For Loop

| Feature | Splat | For Loop |
|----------|---------|---------|
| Short Syntax | Yes | No |
| Easy to Read | Yes | Moderate |
| Supports Filtering | No | Yes |
| Supports Transformations | No | Yes |
| Works with Maps | No | Yes |

Use splat expressions for simple attribute extraction.

Use for expressions when transformations or filtering are required.

---

# Summary

- Terraform expressions allow dynamic configuration logic.
- Operators include arithmetic, comparison, logical, and conditional operators.
- For expressions can iterate over lists, maps, and objects.
- Objects have a fixed structure, while maps allow dynamic keys.
- Maps can be converted to lists using `keys()` and `values()`.
- Lists can be converted into maps using for expressions.
- Splat expressions provide a shortcut for extracting attributes from lists.
- Splat expressions do not work directly with maps created using `for_each`.
- For expressions are more powerful and flexible than splat expressions.