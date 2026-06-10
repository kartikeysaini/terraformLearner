# Terraform Object Variables

## Overview

Terraform objects are used when you want to group multiple related values into a single variable while enforcing a fixed structure.

An object allows you to define exactly which attributes are expected and what data type each attribute should have.

Example:

```hcl
variable "ec2_volume_config" {
  type = object({
    size = number
    type = string
  })

  description = "The size and type of the volume for EC2 instance"

  default = {
    size = 10
    type = "gp3"
  }
}
```

---

## Why Use Objects?

Objects help enforce a predefined structure for input values.

In the above example:

- `size` must be a number.
- `type` must be a string.
- Any missing required attribute will result in a validation error.
- Any incorrect data type will result in a validation error.

Example of a valid value:

```hcl
ec2_volume_config = {
  size = 20
  type = "gp3"
}
```

Example of an invalid value:

```hcl
ec2_volume_config = {
  size = "20"
  type = "gp3"
}
```

Error:

```text
size must be a number
```

---

## Accessing Object Attributes

Object attributes can be accessed using dot notation.

Example:

```hcl
resource "aws_instance" "web" {

  root_block_device {
    volume_size = var.ec2_volume_config.size
    volume_type = var.ec2_volume_config.type
  }
}
```

---

# Objects vs Maps

Both objects and maps store key-value pairs, but they differ in how strictly Terraform validates their structure.

| Feature | Object | Map |
|----------|---------|---------|
| Fixed Structure | Yes | No |
| Attribute Validation | Yes | No |
| Different Value Types | Yes | Usually same type |
| Best For | Structured configurations | Dynamic key-value data |

---

## Object Example

```hcl
variable "ec2_volume_config" {
  type = object({
    size = number
    type = string
  })
}
```

Expected structure:

```hcl
{
  size = 10
  type = "gp3"
}
```

Terraform validates both keys and their data types.

---

## Map Example

```hcl
variable "instance_tags" {
  type = map(string)
}
```

Value:

```hcl
instance_tags = {
  Environment = "Dev"
  Owner       = "Kartikey"
  Project     = "Terraform"
}
```

A map does not require predefined keys.

You can add or remove keys as needed:

```hcl
instance_tags = {
  Environment = "Prod"
  Team        = "Platform"
  CostCenter  = "IT"
}
```

---

## When to Use Objects

Use objects when:

- The input must follow a fixed structure.
- You want validation of attributes.
- Multiple related settings belong together.
- Configuration consistency is important.

Examples:

- EC2 volume configuration
- Database configuration
- Network settings
- Application settings

---

## When to Use Maps

Use maps when:

- Keys are dynamic.
- The number of entries is unknown.
- You need flexible key-value storage.

Examples:

- Resource tags
- Environment variables
- Configuration lookups
- Region mappings

---

## Summary

- Objects provide a fixed, strongly typed structure.
- Terraform validates both attributes and their data types.
- Maps provide flexible key-value storage without predefined keys.
- Objects are best for configuration data.
- Maps are best for dynamic values such as tags and lookups.