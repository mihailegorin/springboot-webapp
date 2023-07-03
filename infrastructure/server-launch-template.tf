# ----------------------------------------
# Linux server with Spring Boot Application
# ----------------------------------------

resource "aws_launch_template" "web" {
  name                   = "${var.application_name}-LT"
  image_id               = var.application_worker_ami
#  image_id               = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.application_server_security_group.id]
  user_data              = base64encode(templatefile("${path.module}/user_data/startup_java.sh.tpl", {
    artifact_bucket     = var.bucket_name,
    application_version = var.application_version
  }))

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }
}

# If you don't have AMI with installed Java in using region –>
# –> Uncomment and set it to aws_launch_template.web.image_id
#    and use install_startup_java
#
#data "aws_ami" "latest_amazon_linux" {
#  owners      = ["amazon"]
#  most_recent = true
#  filter {
#    name   = "name"
#    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
#  }
#}