Learning about providers

Q -> what if i want to create resources in different regions of the same provide
A -> for this we use alias for provider region which we can use in the resource using provider options which gives the option to
use different regions. 

Example -> check providers.tf for the example


also if we make any changes in the providers of the terraform file , we will have to initialize the terraform as well.

using -> terraform init -upgrade