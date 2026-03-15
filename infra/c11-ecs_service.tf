# --- ECS Service ---
resource "aws_ecs_service" "notification" {
  name            = "${var.environment}-${local.service_name}"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.notification.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.notification.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.notification.arn
    container_name   = local.service_name
    container_port   = local.container_port
  }
}