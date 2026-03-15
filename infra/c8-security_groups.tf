# --- Security Group ---
resource "aws_security_group" "notification" {
  name        = "${var.environment}-${local.service_name}-sg"
  description = "Security group for notification service"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = local.container_port # 3000 only
    to_port         = local.container_port # 3000 only
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id] # ALB only, no IP ranges
    description     = "Allow inbound from ALB only"
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "MongoDB Atlas"
  }

  tags = local.common_tags
}