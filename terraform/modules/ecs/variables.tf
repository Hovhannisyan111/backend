variable "cluster_name" {
  default = "ecs-cluster"
}

variable "task_policy_name" {
  default = "back_task_policy"
}

variable "task_role_name" {
  default = "BackendTaskRole"
}

variable "backend_ecr_url" {}

variable "dynamodb_table_name" {
  default = "prod-table"
}

variable "aws_region" {
  default = "eu-central-1"
}

variable "backend_container_name" {
  default = "back-container"
}

