# ECS (Elastic Container Service) Module

This Terraform module provisions an **AWS ECS Cluster** with **Fargate** launch type and associated resources for running containerized applications.

---

## 📦 Resources Created

- `aws_ecs_cluster`
- `aws_ecs_task_definition`
- `aws_ecs_service`

---

## 📥 Input Variables

| Name             | Description                              | Type   | Default        |
|------------------|------------------------------------------|--------|----------------|
| `env`            | Environment name for tagging             | string | `"dev"`        |
| `task_definition`| The ECS task definition configuration    | string | `"backend"`    |
| `cpu`            | The number of CPU units                  | string | `"256"`        |
| `memory`         | The amount of memory allocated           | string | `"512"`        |
| `desired_count`  | The number of desired ECS tasks          | number | `1`            |

---

## 📤 Outputs

| Name            | Description                                |
|-----------------|--------------------------------------------|
| `cluster_name`  | The name of the ECS cluster                |
| `service_name`  | The name of the ECS service                |

---

## 🚀 Example Usage

```hcl
module "ecs" {
  source             = "../modules/ecs"
  env                = "dev"
  task_definition    = "backend"
  cpu                = "256"
  memory             = "512"
  desired_count      = 1
}

