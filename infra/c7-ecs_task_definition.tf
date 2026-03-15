# --- Task Definition ---
resource "aws_ecs_task_definition" "notification" {
  family                   = "${var.environment}-${local.service_name}-task"
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([{
    name      = local.service_name
    image     = "${aws_ecr_repository.notification.repository_url}:latest"
    essential = true

    portMappings = [{
      containerPort = local.container_port
      hostPort      = local.container_port
      protocol      = "tcp"
    }]

    environment = [
      {
        name  = "NODE_ENV"
        value = var.environment
      },
      {
        name  = "PORT"
        value = tostring(local.container_port)
      }
    ]

    secrets = [
      {
      name      = "MONGODB_URI"
      valueFrom = var.mongodb_secret_arn   # ARN of the secret in Secrets Manager
    }

    ]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = aws_cloudwatch_log_group.notification.name
        "awslogs-region"        = var.aws_region
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])

  tags = local.common_tags
}

# BUG Found with terraform plan command and casual lookup
# 1st: security issue -> Mongodb atlas db password is stored hardcoded in environment variable. Which will reveal the key publically when terraform manifest will be uploaded onto remote repo.
# To fix this we will create vault in secrets manager and provide the value into secrets using attribute "valueFrom" which will be given the arn to that secret

# 2nd: Container mapping is incorrect. As container port is set at 3000 which means application will be running inside container on 3000, but the host port hardcoded to 8080 which will eventualluy fails the healthcheck at target group level.
# Fix will be using same as container port to map the host and containers port.

# 3rd: in environment variables providing port cannot pass the numeric value it needed to be using plain text values.
# Fix: use tostring() function which will convert the numeric to plain string.