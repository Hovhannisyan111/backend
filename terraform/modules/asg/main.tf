resource "aws_appautoscaling_target" "backend_scale" {
  max_capacity       = var.max_backend_capacity
  min_capacity       = var.min_backend_capacity
  resource_id        = "service/${var.cluster_name}/${var.backend_service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "backend_tracking" {
  name               = "backend-tracking-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.backend_scale.resource_id
  scalable_dimension = aws_appautoscaling_target.backend_scale.scalable_dimension
  service_namespace  = aws_appautoscaling_target.backend_scale.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = var.target_utilization_percent
    scale_in_cooldown  = var.cooldown_period
    scale_out_cooldown = var.cooldown_period
  }
}
