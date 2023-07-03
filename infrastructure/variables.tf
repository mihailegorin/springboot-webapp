variable "application_name" {
  type = string
}

variable "application_version" {
  type = string
}

variable "application_worker_ami" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "backend_port" {
  default = 8080
}

variable "frontend_port" {
  default = "80"
}

variable "subnets" {
  default = [
    {
      az     = "us-east-2a",
      prefix = "10.1.1.0/24"
    },
    {
      az     = "us-east-2b",
      prefix = "10.1.2.0/24"
    },
    {
      az     = "us-east-2c",
      prefix = "10.1.3.0/24"
    }
  ]
}

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

variable "autoscaling" {
  default = {
    min = 2
    max = 4
    desired = 2
  }
}
