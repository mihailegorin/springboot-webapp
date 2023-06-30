resource "aws_security_group" "web" {
  name        = "${var.application_name}-Server-SG"
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