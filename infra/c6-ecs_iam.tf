# --- IAM Roles ---
# BUG(S) BELOW: Task execution role and task role

resource "aws_iam_role" "task_execution_role" {
  name = "${var.environment}-${local.service_name}-execution"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "task_execution_policy" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "secrets_read" {
  name = "${var.environment}-${local.service_name}-secrets"
  role = aws_iam_role.task_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["secretsmanager:GetSecretValue"]
      Resource = [var.mongodb_secret_arn]
    }]
  })
}

# BUG Found with terraform validate command
# Error: "policy_arn" (arn:aws:iam::policy/AmazonECSTaskExecutionRolePolicy) is an invalid ARN: arn: not enough sections
# │ 
# │   with aws_iam_role_policy_attachment.task_execution_policy,
# │   on c6-ecs_iam.tf line 23, in resource "aws_iam_role_policy_attachment" "task_execution_policy":
# │   23:   policy_arn = "arn:aws:iam::policy/AmazonECSTaskExecutionRolePolicy"

# FIX is to use proper arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy. Take it from aws console IAM -> Policies -> search "AmazonECSTaskExecutionRolePolicy" -> copy the arn

# Fix: Wrong Principal service ec2.amazonaws.com given. 
# We need to put ecs-tasks.amazonaws.com as this role will be attached to task definition in ecs so it reuires ecs-tasks instead of ec2.