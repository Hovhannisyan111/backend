output "backend_service_url" {
  value = "http://${module.lb.lb_dns_name}"
}

output "backend_ecr_url" {
  value = module.ecr.backend_ecr_url
}

output "dynamodb_table_name" {
  value = module.dynamodb.table_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "ecs_cluster_id" {
  value = module.ecs.ecs_cluster_id
}

output "execution_role_arn" {
  value = module.ecs.execution_role_arn
}

output "cluster_name" {
  value = module.ecs.cluster_name
}
