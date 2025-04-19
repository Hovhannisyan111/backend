# Terraform Project - Backend Infrastructure

This Terraform configuration is used to deploy and manage the backend infrastructure in AWS, which includes the following resources:
- VPC (Virtual Private Cloud)
- Security Groups (SG)
- DynamoDB Table
- ECR (Elastic Container Registry)
- Load Balancer (ALB)
- ECS (Elastic Container Service) Fargate tasks
- Auto Scaling Group (ASG)

The resources are provisioned using Terraform modules, all sourced from a GitHub repository.

---

## 📦 Resources Created

- **VPC**: Creates a new VPC with subnets and internet gateway.
- **Security Groups**: Configures security groups for backend services.
- **DynamoDB Table**: Creates a DynamoDB table for persistent storage.
- **ECR Repository**: Creates a private ECR repository for storing Docker images.
- **Load Balancer**: Sets up an Application Load Balancer (ALB) to distribute traffic across ECS services.
- **ECS Services**: Deploys ECS services running backend tasks with a specified task definition.
- **Auto Scaling Group**: Creates an ASG for scaling ECS tasks.

---

## 📥 Input Variables

| Name                   | Description                                       | Type   | Default        |
|------------------------|---------------------------------------------------|--------|----------------|
| `env`                  | The environment name (for tagging)                | string | `"dev"`        |
| `vpc_id`               | The ID of the VPC                                 | string | `n/a`          |
| `public_subnet_ids`    | List of public subnet IDs                         | list   | `[]`           |
| `table_name`           | DynamoDB table name                               | string | `"Backend-table"`|
| `hash_key`             | Hash key for DynamoDB table                       | string | `"id"`         |
| `ecr_repo_name`        | Name of the ECR repository                        | string | `"backend"`    |
| `backend_path`         | Path to the backend Docker context for ECR        | string | `""`           |
| `lb_name`              | Name of the Load Balancer                         | string | `"Back-load-balancer"`|
| `cluster_name`         | Name of the ECS cluster                           | string | `"ECS-cluster"`|
| `backend_container_name`| Name of the backend container in ECS            | string | `"Backend-container"`|
| `task_policy_name`     | Name of the task policy                           | string | `"Backend_Task_Policy"`|
| `task_role_name`       | Name of the task role                             | string | `"BackendTaskRole"`|
| `scaling_adjustment`   | The scaling adjustment for the ASG                | number | `1`            |
| `max_backend_capacity` | Maximum capacity for backend ECS tasks            | number | `2`            |
| `min_backend_capacity` | Minimum capacity for backend ECS tasks            | number | `1`            |

---

## 📤 Outputs

| Name                   | Description                                        |
|------------------------|----------------------------------------------------|
| `backend_service_url`  | URL of the deployed backend service               |
| `backend_ecr_url`      | URL of the ECR repository                         |
| `dynamodb_table_name`  | Name of the DynamoDB table                        |
| `vpc_id`               | ID of the created VPC                             |
| `public_subnet_ids`    | List of public subnet IDs                         |
| `ecs_cluster_id`       | ID of the ECS cluster                             |
| `execution_role_arn`   | ARN of the ECS execution role                     |
| `cluster_name`         | Name of the ECS cluster                           |

---

## 🚀 Example Usage

```hcl
module "vpc" {
  source = "git::https://github.com/Hovhannisyan111/backend.git//terraform/modules/vpc?ref=main"
}

module "sg" {
  source      = "git::https://github.com/Hovhannisyan111/backend.git//terraform/modules/sg?ref=main"
  sg_name     = "Backend-Security"
  vpc_id      = module.vpc.vpc_id
  allow_ports = [80, 443]
}

module "dynamodb" {
  source     = "git::https://github.com/Hovhannisyan111/backend.git//terraform/modules/dynamodb?ref=main"
  table_name = "Backend-table"
  hash_key   = "id"
}

module "ecr" {
  source        = "git::https://github.com/Hovhannisyan111/backend.git//terraform/modules/ecr?ref=main"
  ecr_repo_name = "backend"
  backend_path  = "../../docker"
}

module "lb" {
  source            = "git::https://github.com/Hovhannisyan111/backend.git//terraform/modules/lb?ref=main"
  lb_name           = "Back-load-balancer"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  tg_backend_port   = 80
  security_group_id = module.sg.security_group_id
  back_health_port  = 80
  listener_port     = 80
}

module "ecs" {
  source                 = "git::https://github.com/Hovhannisyan111/backend.git//terraform/modules/ecs?ref=main"
  cluster_name           = "ECS-cluster"
  backend_container_name = "Backend-container"
  backend_ecr_url        = module.ecr.backend_ecr_url
  dynamodb_table_name    = module.dynamodb.table_name
  task_policy_name       = "Backend_Task_Policy"
  task_role_name         = "BackendTaskRole"
}

module "services" {
  source                 = "git::https://github.com/Hovhannisyan111/backend.git//terraform/modules/service?ref=main"
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
  source               = "git::https://github.com/Hovhannisyan111/backend.git//terraform/modules/asg?ref=main"
  cluster_name         = module.ecs.cluster_name
  backend_service_name = module.services.backend_service_name
  max_backend_capacity = 2
  min_backend_capacity = 1
  scaling_adjustment   = 1
  cooldown_period      = 300
}
