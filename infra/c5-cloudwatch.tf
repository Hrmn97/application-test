# --- CloudWatch Log Group ---
resource "aws_cloudwatch_log_group" "notification" {
  name              = "/ecs/${var.environment}-${local.service_name}"
  retention_in_days = 0

  tags = local.common_tags
}