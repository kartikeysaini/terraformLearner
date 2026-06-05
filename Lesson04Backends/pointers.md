Backend

A backend is used to determine where Terraform stores its state file (terraform.tfstate). The state file keeps track of all infrastructure resources managed by Terraform and is a critical part of Terraform operations.

Problem

If multiple developers work on the same project and store the state file locally, each developer may have a different copy of the state file. This can lead to conflicts, inconsistent infrastructure, and accidental overwrites.

Solution

Store the state file in a remote backend such as:

Amazon S3
Terraform Cloud

A remote backend allows all team members to use the same state file.

Example S3 Backend

terraform {
  backend "s3" {
    bucket = "terraformremotebackendtester01"
    key    = "state.tfstate"
    region = "ap-south-1"
  }
}

The S3 bucket must already exist before Terraform can use it as a backend.

Backend Configuration Change

Initial configuration:

terraform {
  backend "s3" {
    bucket = "terraformremotebackendtester01"
    key    = "state.tfstate"
    region = "ap-south-1"
  }
}

Updated configuration:

terraform {
  backend "s3" {
    bucket = "terraformremotebackendtester01"
    key    = "lesson04/state.tfstate"
    region = "ap-south-1"
  }
}

After changing the backend configuration and running:

terraform init

Terraform detects that the backend configuration has changed and displays:

Error: Backend configuration changed

To migrate the existing state to the new backend location, run:

terraform init -migrate-state

Terraform will copy the existing state from the old backend location to the new one.

This migration is only relevant when Terraform already has existing state to move. If no state exists yet, there is nothing to migrate.