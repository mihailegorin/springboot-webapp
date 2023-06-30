# ----------------------------------------
# Linux server with Spring Boot Application
# ----------------------------------------

resource "aws_instance" "my_web_server" {
  ami                    = var.worker_ami
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  user_data              = templatefile("app_deployment/user_data.sh.tpl", {
    artifact_bucket     = var.bucket_name,
    application_version = var.application_version
  })

  tags = {
    Name = "${var.application_name}-Server"
  }
}

resource "aws_security_group" "web" {
  name        = "${var.application_name}-Server-Security-Group"
  description = "Manage traffic to app server"

  dynamic "ingress" {
    for_each = ["8080", "22", "80"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Security Group"
    Owner = "Mihail Egorin"
  }
}
