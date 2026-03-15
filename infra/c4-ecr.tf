# --- ECR Repository ---
resource "aws_ecr_repository" "notification" {
  name                 = "${var.environment}-${local.service_name}"
  image_tag_mutability = "MUTABLE"

  tags = local.common_tags
}