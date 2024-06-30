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

provider "aws" {
  region  = "us-west-2"
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"
  tags = {
    Name = var.instance_name
  }
}
