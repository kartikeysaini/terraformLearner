## Terraform Data Sources

### What are Data Sources?

Data Sources are used to **fetch information about existing resources** that are already present in the cloud provider or another system.

Unlike resources, Data Sources do **not create or modify infrastructure**. They only read information and make it available for use in Terraform configurations.

---

### Why do we use Data Sources?

Sometimes we need information about existing infrastructure instead of creating everything from scratch.

Examples:

* Get the latest Amazon Linux AMI ID.
* Fetch details of an existing VPC.
* Retrieve information about an existing Security Group.
* Get subnet IDs from an already created VPC.

---

### Example

Instead of hardcoding an AMI ID:

```hcl
resource "aws_instance" "web" {
  ami           = "ami-07b301a23def3266d"
  instance_type = "t2.micro"
}
```

We can fetch the latest AMI dynamically:

```hcl
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }
}
```

Use it in a resource:

```hcl
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
}
```

---

### Important Points

* Data Sources only read information.
* They do not create resources.
* They help avoid hardcoding values.
* Their values can be referenced using:

```hcl
data.<provider_resource_type>.<name>.<attribute>
```

Example:

```hcl
data.aws_ami.amazon_linux.id
```

---

### Resource vs Data Source

| Resource                                     | Data Source                             |
| -------------------------------------------- | --------------------------------------- |
| Creates or manages infrastructure            | Reads existing infrastructure           |
| Uses `resource` keyword                      | Uses `data` keyword                     |
| Changes are applied during `terraform apply` | Information is fetched during execution |
| Example: EC2 Instance                        | Example: Existing AMI                   |

---

# Terraform Outputs

### What are Outputs?

Outputs are used to display information after Terraform creates or updates infrastructure.

They help expose important values from Terraform resources.

---

### Why do we use Outputs?

After creating infrastructure, we often need information such as:

* EC2 Public IP
* EC2 Private IP
* VPC ID
* Subnet ID
* Load Balancer DNS Name

Instead of searching for these values manually in AWS, Terraform can display them automatically.

---

### Example

Create an EC2 instance:

```hcl
resource "aws_instance" "web" {
  ami           = "ami-07b301a23def3266d"
  instance_type = "t2.micro"
}
```

Output its Public IP:

```hcl
output "public_ip" {
  value = aws_instance.web.public_ip
}
```

After:

```bash
terraform apply
```

Terraform displays:

```text
Outputs:

public_ip = "13.232.xx.xx"
```

---

### Multiple Outputs

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

---

### Viewing Outputs

After infrastructure is created:

```bash
terraform output
```

Output:

```text
instance_id = "i-0123456789abcdef"
public_ip   = "13.232.xx.xx"
private_ip  = "172.31.x.x"
```

To view a specific output:

```bash
terraform output public_ip
```

---

### Important Points

* Outputs display useful information after deployment.
* Outputs can be referenced by other Terraform configurations when using modules.
* Outputs do not create resources.
* They make important resource attributes easily accessible.

---

### Summary

**Data Sources**

* Used to fetch existing information.
* Do not create resources.
* Help avoid hardcoded values.
* Example: Fetch latest AMI, existing VPC, existing subnet.

**Outputs**

* Used to display information after deployment.
* Show values such as IP addresses, IDs, and DNS names.
* Help users quickly access resource details.
* Retrieved using `terraform output`.
