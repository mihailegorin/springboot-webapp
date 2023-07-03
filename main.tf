# --------------------------------------------------
# Infrastructure entry point
# --------------------------------------------------

module "application" {
  source                 = "./infrastructure"
  application_name       = "Spring-Boot-Application"
  application_version    = var.application_version
  application_worker_ami = "ami-01912afb5d1edc9b1"
  bucket_name            = "mihail-egorin.spring-boot-webapp"
  backend_port           = 8080
  subnets                = [
    {
      az     = "us-west-2a",
      prefix = "10.1.1.0/24"
    },
    {
      az     = "us-west-2b",
      prefix = "10.1.2.0/24"
    },
    {
      az     = "us-west-2c",
      prefix = "10.1.3.0/24"
    }
  ]
}

# --------------------------------------------------
variable "application_version" {
  type    = string
  default = "028a139"
}
# --------------------------------------------------
output "web_loadbalancer_url" {
  value = module.application.web_loadbalancer_url
}
# --------------------------------------------------
# Providers
# --------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2.0"
    }
  }
  backend "s3" {
    bucket = "mihail-egorin.spring-boot-webapp"
    key    = "remote_state/terraform.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      Owner     = "Mihail Egorin"
      CreatedBy = "Terraform"
    }
  }
}
