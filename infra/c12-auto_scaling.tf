# --- Auto Scaling ---
resource "aws_appautoscaling_target" "notification" {
  max_capacity       = 4
  min_capacity       = 1
  resource_id        = "service/${var.ecs_cluster_id}/${aws_ecs_service.notification.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "notification_cpu" {
  name               = "${var.environment}-${local.service_name}-cpu-scaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.notification.resource_id
  scalable_dimension = aws_appautoscaling_target.notification.scalable_dimension
  service_namespace  = aws_appautoscaling_target.notification.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 95.0
  }
}
