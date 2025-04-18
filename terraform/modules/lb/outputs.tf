output "lb_dns_name" {
  value = aws_lb.app_lb.dns_name
}
output "backend_tg_arn" {
  value = aws_lb_target_group.backend_tg.arn
}
