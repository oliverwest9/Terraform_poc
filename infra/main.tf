terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  cloud {
    organization = "Olivers_Sandbox_Org"

    workspaces {
      name = "learn-terraform-github-actions"
    }
  }  
  required_version = ">= 1.2.0"
}