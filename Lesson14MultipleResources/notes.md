## Working with count and foreach

### Count

count is a property in terraform for each resource. We can use the index of a count to use the values of the number of instances

for example

to create 2 subnets for a vpc we can use a structure like below

```locals {
  ManagedBy = "Terraform"
  Name      = "Lesson14MultiResource"
}


resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name      = local.Name
    ManagedBy = local.ManagedBy
  }
}

resource "aws_subnet" "main" {
  count      = var.subnet-count
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.${count.index}.0/24"

  tags = {
    Name      = "${local.Name}-${count.index}"
    ManagedBy = local.ManagedBy
  }
}```

here in this example we can see. how in cidr block and Name , we are using count.index for indexing the name and cidr values as two subnets cannot have same cide value


In another example:

We can use the count and modify the count value as well

in below example, to create various instances of ec2, how to attach a subnet to an instance as the subnet instances are also multiple.

we can see that example below

```resource "aws_instance" "main" {
  count         = var.ec2-instance-count
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.main[count.index % length(aws_subnet.main)].id

  tags = {
    Name      = "${local.Name}-${count.index}"
    ManagedBy = local.ManagedBy
  }

}```


Along with Count we will use for_each.

for_each in terraform is used with maps, string etc and does not work with list of objects.


for_each allows us to us various function to validate values

We can also use objects and list of objects to create n number of instances that we pass in the variables instead of hardcoding the values.