# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 3.70"
      version = ">= 4.65"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      #version = "~> 2.7"
      version = ">= 2.20"
    }    
     helm = {
      source = "hashicorp/helm"
      version = "2.16.1"
    }

     http = {
      source = "hashicorp/http"
      version = "3.4.5"
    }
  }
}
