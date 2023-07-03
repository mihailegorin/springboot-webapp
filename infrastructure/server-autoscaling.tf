resource "aws_autoscaling_group" "web" {
  name                = "${var.application_name}-ASG-V.${aws_launch_template.web.latest_version}"
  desired_capacity    = var.autoscaling.desired
  max_size            = var.autoscaling.max
  min_size            = var.autoscaling.min
  vpc_zone_identifier = [for subnet in module.network.subnet_ids : subnet.subnet_id]
  target_group_arns   = [aws_lb_target_group.web.arn]
  health_check_type   = "ELB"

  launch_template {
    id      = aws_launch_template.web.id
    version = aws_launch_template.web.latest_version
  }

  lifecycle {
    create_before_destroy = true
  }
}