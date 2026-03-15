# --- ALB Target Group ---
resource "aws_lb_target_group" "notification" {
  name        = "${var.environment}-notif-tg"
  port        = local.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    matcher             = "200"
  }

  tags = local.common_tags
}