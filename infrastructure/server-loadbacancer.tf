#===========DEFAULT ===================
resource "aws_lb" "web" {
  name               = "${var.application_name}-LB"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_security_group.id]
  subnets            = [for subnet in module.network.subnet_ids : subnet.subnet_id]
}

resource "aws_lb_target_group" "web" {
  name                 = "${var.application_name}-TG"
  vpc_id               = module.network.vpc_id
  port                 = var.backend_port
  protocol             = "HTTP"
  deregistration_delay = 10
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web.arn
  port              = var.frontend_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}
