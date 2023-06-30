# ----------------------------------------
# Linux server with Spring Boot Application
# ----------------------------------------

resource "aws_launch_template" "web" {
  name                   = "${var.application_name}-Server-LT"
  image_id               = var.worker_ami
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
    arn = aws_iam_instance_profile.ec2_profile.arn
  }
  user_data              = templatefile("infrastructure/user_data.sh.tpl", {
    artifact_bucket     = var.bucket_name,
    application_version = var.application_version
  })
}