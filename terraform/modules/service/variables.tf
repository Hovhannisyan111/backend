variable "ecs_cluster_id" {}
variable "backend_task" {}
variable "security_group_id" {}
variable "public_subnet_ids" {
  default = []
}

variable "backend_tg_arn" {
  default = ""
}

variable "backend_container_name" {
  default = "backend-service"
}

variable "backend_service_name" {
  default = "backend-service"
}

variable "backend_container_port" {
  default = 80
}
