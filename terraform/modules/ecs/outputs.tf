output "cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "ecs_cluster_id" {
  value = aws_ecs_cluster.main.id
}

output "backend_task_arn" {
  value = aws_ecs_task_definition.backend.arn
}

output "backend_task_role_arn" {
  value = aws_iam_role.backend_task_role.arn
}

output "execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "backend_container_name" {
  value = var.backend_container_name
}

