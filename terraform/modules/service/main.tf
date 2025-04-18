resource "aws_ecs_service" "backend" {
  name            = var.backend_service_name
  cluster         = var.ecs_cluster_id
  task_definition = var.backend_task
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = [var.public_subnet_ids[1]]
    security_groups  = [var.security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.backend_tg_arn
    container_name   = var.backend_container_name
    container_port   = var.backend_container_port
  }
}
