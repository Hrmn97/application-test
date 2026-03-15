variable "environment" {
  type    = string
  default = "production"
}

variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ecs_cluster_id" {
  type = string
}

variable "alb_arn" {
  type = string
}

variable "alb_listener_arn" {
  type = string
}

variable "alb_security_group_id" {
  type = string
}

variable "mongodb_secret_arn" {
  type = string
}