# ECS Service Module

This Terraform module provisions an **AWS ECS Service** that runs a Fargate task within an ECS cluster, utilizing an ALB for load balancing.

---

## 📦 Resources Created

- `aws_ecs_service`

---

## 📥 Input Variables

| Name             | Description                              | Type   | Default        |
|------------------|------------------------------------------|--------|----------------|
| `task_definition`| The ECS task definition to use           | string | `"backend"`    |
| `cluster_id`     | The ECS cluster ID                       | string | `n/a`          |
| `desired_count`  | The number of ECS tasks to run           | number | `1`            |

---

## 📤 Outputs

| Name            | Description                            |
|-----------------|----------------------------------------|
| `service_name`  | Name of the ECS service               |

---

## 🚀 Example Usage

```hcl
module "service" {
  source             = "../modules/service"
  cluster_id        = module.ecs.cluster_name
  task_definition   = "backend"
  desired_count     = 1
}

