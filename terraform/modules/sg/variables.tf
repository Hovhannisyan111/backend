variable "sg_name" {
  default = "Backend Security Group"
}

variable "vpc_id" {
  default = ""
}

variable "allow_ports" {
  default = [8080, 443]
}

variable "cidr_blocks" {
  default = ["0.0.0.0/0"]
}
