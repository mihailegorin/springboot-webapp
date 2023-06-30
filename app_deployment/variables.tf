variable "application_name" {
  type = string
}

variable "application_version" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "worker_ami" {
  type = string
}

variable "instance_profile" {
  type = string
}

variable "backend_port" {
  default = 8000
}
