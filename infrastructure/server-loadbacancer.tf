resource "aws_lb" "web" {
  name               = "${var.application_name}-Server-ALB"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web.id]
  subnets            = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
}

resource "aws_lb_target_group" "web" {
  name                 = "${var.application_name}-Server-TG"
  vpc_id               = aws_default_vpc.default.id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 10 // seconds
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}
