locals {
  service_name   = "notification-service"
  container_port = 3000
  common_tags = {
    Environment = var.environment
    Service     = local.service_name
    ManagedBy   = "terraform"
  }
}