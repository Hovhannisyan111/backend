variable "cluster_name" {
  default = ""
}

variable "backend_service_name" {
  default = ""
}

variable "max_backend_capacity" {
  default = 2
}

variable "min_backend_capacity" {
  default = 1
}

variable "scaling_adjustment" {
  default = 1
}

variable "cooldown_period" {
  default = 300
}

variable "target_utilization_percent" {
  default = 50
}

