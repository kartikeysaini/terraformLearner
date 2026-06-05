Partial backends

This is for templating the backends in a seperate file. Instead of hardcoding a backend, we can seperate it in different files according to the environment. So with same tf file we can use different backend files

For example

We have a tf file 

Terraform {

	# code for providers

	Backends {
	# leaving this empty
}
}


We can create a separate file for backends with name 

S3.dev.tfbackend
S3.prod.tfbackend

And keep the values of the backend in the tfbackend file

And then pass the file name while initializing the terraform

Terraform init -backend-config=”s3.dev.tfbackend” -migrate-state
