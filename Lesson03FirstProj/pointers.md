We can divide the files of terraform in terms of resources, providers, variables in seperate files. like here in this project, the providers are in firstProj.tf file and resources are in firstProjResources.tf file

there are some commands we can use in terraform 

1. terraform init -> to initialize project and add the providers to the project
2. terraform fmt -> format files properly to have proper indentation and remove extra spacing
3. terraform validate -> helps in validation of the format of the terraform file. does not work properly as if anything has to go wrong will go wrong when we run the file
4. terraform plan -> to create the plan of the terraform file before we apply the changes. this gives us all the changes that are done in the tf file
5. terraform plan -out <file-name> -> gives a filename which we can use for applying the config
6. terraform apply -> applies the default file and asks for prompt of yes and no
7. terraform apply <file-name> -> directly applies the file without asking for permission.
8. terraform show -> shows the state file and what is currently in the tf project
9. terraform show <file-name> -> shows the given file name configuration . makes the unreadable file readable
10. terraform state list -> list of all the resources, more concise
11. terraform plan -destroy ->  shows what it will remove , does not apply
12. terraform apply -destroy -> gives us prompt for confirmation and then destroys the resources
13. terraform apply <command name> -auto-approve -> does not give prompt and does the action
14. terraform -help 



terraform state file -> this stores the configuration of the realworld objects
1. state is a required file in terraform
2. state contians extremely sensitive data
3. stores metadata like resource dependencies
4. before any operation, terraform refrehes the state with the information from the respective real world objects- means if there are any changes that are done to the resources outside terraform, the terraform checks the resources through the API . this is called configuration drift. if the reall world resoource has been updated and respective config does not reflect it. terraform will revert the changes
5. state can be stored in s3 or locally
6. state locking is helpful to avoid concurrent changes