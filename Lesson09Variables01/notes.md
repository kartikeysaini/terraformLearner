Variables are used to make Terraform configurations dynamic. Instead of hardcoding values in the Terraform files, we can pass values at runtime.

This allows the same Terraform code to be reused in different environments and scenarios.

Creating a Variable

In variables.tf, we can define a variable:

variable "aws_region" {
  type = string
}

This tells Terraform that a variable named aws_region will be provided and its value must be a string.

Using the Variable

We can use the variable in our provider configuration:

provider "aws" {
  region = var.aws_region
}

Here, var.aws_region refers to the value supplied for the variable.

Providing the Value

If no value is supplied through any other method, Terraform will prompt for it during:

terraform plan

Example:

var.aws_region
Enter a value:

The entered value will then be used in the Terraform execution.

Advantages of Variables
Makes Terraform code reusable.
Avoids hardcoded values.
Allows the same configuration to be used for different environments.
Makes infrastructure more flexible and configurable.

Example:

terraform apply -var="aws_region=ap-south-1"

or

terraform apply -var="aws_region=us-east-1"

without changing the code.

Important Consideration

Variables themselves are not dangerous.

The real issue is that Terraform tracks infrastructure using the state file.

For example:

First Run
terraform apply -var="aws_region=ap-south-1"

Terraform creates:

EC2 Instance -> Mumbai (ap-south-1)

State file:

terraform.tfstate

contains information about that instance.

Second Run

If you now change the region:

terraform apply -var="aws_region=us-east-1"

Terraform sees that the provider configuration has changed.

Depending on the resources, Terraform may:

Destroy the old resource and create a new one.
Replace resources.
Update the state accordingly.

Terraform does not simply forget about the old infrastructure.

The behavior depends on how the resource is affected by the change and what exists in the state file.

Real Risk

The actual risk occurs when you want to manage multiple environments (such as Mumbai and Virginia) using the same Terraform code and state file.

In such cases, it is common to use:

Separate state files
Separate workspaces
Separate backend keys
Separate Terraform projects

This prevents one environment from interfering with another.

Ways to Provide Variable Values
1. Interactive Input

Terraform asks for the value:

terraform plan

Output:

var.aws_region
Enter a value:
2. Command Line Argument
terraform apply -var="aws_region=ap-south-1"