#!/usr/bin/env bash
set -e

echo "Create base terraform templates"
touch 5-main.tf data.tf 6-outputs.tf

if [ ! -f 1-versions.tf ]
then
  echo "Create providers file"
  cat > 1-versions.tf <<- VERSIONS
provider "aws" {
  region = var.region

  default_tags {
    tags = {
      created_by = "terraform"
    }
  }
}
VERSIONS
fi

if [ ! -f 2-providers.tf ]
then
  echo "Create providers file"
  cat > 2-providers.tf <<- PROVIDERS
provider "aws" {
  region = var.region

  default_tags {
    tags = {
      created_by = "terraform"
    }
  }
}
PROVIDERS
fi

if [ ! -f 3-variables.tf ]
then
  echo "Create variables file"
  cat > 3-variables.tf <<- VARIABLES
variable "region" {
  description = "AWS region to create resources in"
  type  = string
  default = "us-east-1"
}
VARIABLES
fi

if [ ! -f 4-locals.tf ]
then
  echo "Create locals template file"
  cat > 4-locals.tf <<- LOCALS
locals {
}
LOCALS
fi

if [ ! -f backend.tf ]
then
  echo "Create backend template file"
  cat > backend.tf <<- BACKEND
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
  }
}
BACKEND
fi

echo "Create default terraform variable file"
mkdir -p tfvars && touch tfvars/main.tfvars

echo "Create .gitignore file"
cat > .gitignore <<- IGNORE
# Local .terraform directories
**/.terraform/*

# .tfstate files
*.tfstate
*.tfstate.*

# Crash log files
crash.log
crash.*.log

# Exclude all .tfvars files, which are likely to contain sensitive data, such as
# password, private keys, and other secrets. These should not be part of version 
# control as they are data points which are potentially sensitive and subject 
# to change depending on the environment.
*.tfvars
*.tfvars.json

# Ignore override files as they are usually used to override resources locally and so
# are not checked in
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# Ignore transient lock info files created by terraform apply
.terraform.tfstate.lock.info

# Include override files you do wish to add to version control using negated pattern
# !example_override.tf

# Include tfplan files to ignore the plan output of command: terraform plan -out=tfplan
# example: *tfplan*

# Ignore CLI configuration files
.terraformrc
terraform.rc

# Housekeeping
.vscode/*
!.vscode/settings.json
!.vscode/tasks.json
!.vscode/launch.json
!.vscode/extensions.json
!.vscode/*.code-snippets
.history/
*.vsix
*.key
*.pem
*.crt

# Python virtual environment directories
venv/
.myenv/
.venv/

# Python bytecode
__pycache__/
*.pyc
*.pyo
*.pyd

# Environment variable files
*.env
IGNORE