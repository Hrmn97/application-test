output "ecr_repository_name" {
  description = "ECR repository name — use as ECR_REPOSITORY in GitHub Actions workflow"
  value       = aws_ecr_repository.notification.name
}

output "ecr_repository_uri" {
  description = "Full ECR repository URI — use for docker build/push commands in CI"
  value       = aws_ecr_repository.notification.repository_url
}

output "ecs_service_name" {
  description = "ECS service name — use as ECS_SERVICE in GitHub Actions workflow"
  value       = aws_ecs_service.notification.name
}

output "ecs_cluster_id" {
  description = "ECS cluster ID/ARN — use as ECS_CLUSTER in GitHub Actions workflow"
  value       = var.ecs_cluster_id
}

output "ecs_task_definition_family" {
  description = "ECS task definition family name — use as ECS_TASK_DEFINITION in GitHub Actions workflow"
  value       = aws_ecs_task_definition.notification.family
}

output "ecs_task_definition_arn" {
  description = "Full ARN of the latest registered task definition revision"
  value       = aws_ecs_task_definition.notification.arn
}

output "container_name" {
  description = "Container name inside the task definition — use as CONTAINER_NAME in GitHub Actions workflow"
  value       = local.service_name
}

output "aws_region" {
  description = "AWS region — needed for ECR login: aws ecr get-login-password --region <region>"
  value       = var.aws_region
}

output "cloudwatch_log_group" {
  description = "CloudWatch log group name — useful for tailing logs after deployment"
  value       = aws_cloudwatch_log_group.notification.name
}

output "target_group_arn" {
  description = "ALB target group ARN — check target health after deployment"
  value       = aws_lb_target_group.notification.arn
}
