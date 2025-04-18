resource "aws_lb" "app_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [var.security_group_id]

  tags = {
    Name = "app-lb"
  }
}

resource "aws_lb_target_group" "backend_tg" {
  name        = "backend-tg"
  port        = var.tg_backend_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    port                = var.back_health_port
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
    protocol            = "HTTP"
  }
}

resource "aws_lb_listener" "backend_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
}

