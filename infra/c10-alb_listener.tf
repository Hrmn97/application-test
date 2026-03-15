# --- ALB Listener Rule ---
resource "aws_lb_listener_rule" "notification" {
  listener_arn = var.alb_listener_arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.notification.arn
  }

  condition {
    path_pattern {
      values = ["/users*"]
    }
  }
}