in this lesson we are learning to create a project where we will do below steps

1. Deploy a VPC and subnet [DONE]
2. deploy internet gateway and associate it with VPC [DONE]
3. setup a route table with a route to the igw and associate it with subnet[DONE]
4. deploy a ec2 instance inside of the created subnet
5. associate public ip and security group that allows public ingress


there are multiple things we are learning in this, like syntax of how various resources look
example -> subnet, vpc, internet gateway, route tables, associations, ec2 instances, nginx. 

these are just syntax which can be found in the documentation. Main part here is how these thing are created and how terraform helps here.

What we have learnt in this project

1. Locals -> these are like global constants which we use inside our code to implement DRY principal.
for example = if we have same tags in multiple resources , instead of adding tags in each resource by hardcoding it
we can define the tags in the locals and then reference that local

locals {
  common_tags = {
    ManagedBy = "Terraform"
    Project   = "MyLearningProject"
  }
}

two ways of referencing locals
A. no changes in the tags
example -> tags = local.common_tags
B. some changes in the tags (using merge function)
example -> tags = merge(local.common_tags,{
    tagName1 = tagValue1
})

Inference -> 
A. with A, all the values in the locals will be referenced no changes
B. with B, the values of local will be referenced and another value which will be dynamic will be merged with the local values






Security Groups in AWS

Security Groups act as virtual firewalls for AWS resources such as EC2 instances. They control inbound (ingress) and outbound (egress) network traffic.

Ingress rules define what incoming traffic is allowed, while egress rules define what outgoing traffic is allowed. These rules are typically based on IP addresses, protocols, and port numbers.

Examples:

Allow SSH access on port 22 from a specific IP address.
Allow HTTP traffic on port 80 from anywhere.
Allow communication between instances that belong to a specific Security Group.

Every VPC contains a default Security Group created by AWS. When an EC2 instance is launched without specifying a Security Group, AWS automatically associates the instance with the VPC's default Security Group.

When using Terraform, a new Security Group is created only if an aws_security_group resource is explicitly defined in the configuration.


Lifecycles in Terraform

we also learnt about lifecycles in terrafrom where 

1. Create Before Destroy -> this is used to create a resource first before destroying the existing resource. this helps with the downtime
2. ignore_changes -> this is used when we are making any changes in the resource outside of the terraform , we can add that parameter to this ignore changes , as if terraform finds any configuration drift, it reverts the manual changes. this helps in ignoring those changes