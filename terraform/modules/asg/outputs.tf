output "backend_scaling_target" {
  value = aws_appautoscaling_target.backend_scale.id
}

output "backend_scaling_policy_name" {
  value = aws_appautoscaling_policy.backend_tracking.name
}
