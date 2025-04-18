module "vpc" {
  source = "../modules/vpc"
}

module "sg" {
  source      = "../modules/sg"
  sg_name     = "Backend-Security"
  vpc_id      = module.vpc.vpc_id
  allow_ports = [80, 443]
}

module "dynamodb" {
  source     = "../modules/dynamodb"
  table_name = "Backend-table"
  hash_key   = "id"
}

module "ecr" {
  source        = "../modules/ecr"
  ecr_repo_name = "backend"
  backend_path  = "../../docker"
}

module "lb" {
  source            = "../modules/lb"
  lb_name           = "Back-load-balancer"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  tg_backend_port   = 80
  security_group_id = module.sg.security_group_id
  back_health_port  = 80
  listener_port     = 80
}

module "ecs" {
  source                 = "../modules/ecs"
  cluster_name           = "ECS-cluster"
  backend_container_name = "Backend-container"
  backend_ecr_url        = module.ecr.backend_ecr_url
  dynamodb_table_name    = module.dynamodb.table_name
  task_policy_name       = "Backend_Task_Policy"
  task_role_name         = "BackendTaskRole"
}

module "services" {
  source                 = "../modules/service"
  backend_service_name   = "Backend"
  backend_container_name = module.ecs.backend_container_name
  ecs_cluster_id         = module.ecs.ecs_cluster_id
  backend_task           = module.ecs.backend_task_arn
  public_subnet_ids      = module.vpc.public_subnet_ids
  security_group_id      = module.sg.security_group_id
  backend_tg_arn         = module.lb.backend_tg_arn
  backend_container_port = 80
}

module "asg" {
  source               = "../modules/asg"
  cluster_name         = module.ecs.cluster_name
  backend_service_name = module.services.backend_service_name
  max_backend_capacity = 2
  min_backend_capacity = 1
  scaling_adjustment   = 1
  cooldown_period      = 300
}
