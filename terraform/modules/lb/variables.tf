variable "listener_port" {
  default = 80
}
variable "vpc_id" {}
variable "public_subnet_ids" {
  default = []
}
variable "lb_name" {
  default = "app-load-balancer"
}
variable "security_group_id" {}
variable "tg_backend_port" {}
variable "back_health_port" {
  default = ""
}

