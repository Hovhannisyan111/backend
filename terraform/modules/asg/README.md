# Auto Scaling Group (ASG) Module

This Terraform module provisions an **AWS Auto Scaling Group (ASG)** for managing the scaling of ECS Fargate tasks.

---

## 📦 Resources Created

- `aws_autoscaling_group`
- `aws_launch_configuration`

---

## 📥 Input Variables

| Name             | Description                              | Type   | Default        |
|------------------|------------------------------------------|--------|----------------|
| `vpc_id`         | The ID of the VPC                        | string | `n/a`          |
| `desired_capacity`| The desired number of tasks to scale to  | number | `1`            |
| `max_size`       | The maximum number of tasks allowed      | number | `5`            |
| `min_size`       | The minimum number of tasks allowed      | number | `1`            |

---

## 📤 Outputs

| Name            | Description                            |
|-----------------|----------------------------------------|
| `asg_name`      | Name of the Auto Scaling Group         |

---

## 🚀 Example Usage

```hcl
module "asg" {
  source             = "../modules/asg"
  vpc_id             = module.vpc.vpc_id
  desired_capacity   = 1
  max_size           = 5
  min_size           = 1
}
