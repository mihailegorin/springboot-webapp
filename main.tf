# --------------------------------------------------
# Infrastructure entry point
# --------------------------------------------------

module "application" {
  source              = "./app_deployment"
  application_name    = "Spring Boot Application"
  application_version = var.application_version
  bucket_name         = "mihail-egorin.spring-boot-webapp"
  worker_ami          = "ami-02ac0f946cb74e8da"
  instance_profile    = "spring-boot-app"
  backend_port        = 8080
}

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
  region = "eu-central-1"

  default_tags {
    tags = {
      Owner     = "Mihail Egorin"
      CreatedBy = "Terraform"
    }
  }
}
