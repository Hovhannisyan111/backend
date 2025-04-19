# Load Balancer (LB) Module

This Terraform module provisions an **AWS Application Load Balancer (ALB)** for routing traffic to ECS services, along with necessary listener rules and target groups.

---

## 📦 Resources Created

- `aws_lb`
- `aws_lb_target_group`
- `aws_lb_listener`

---

## 📥 Input Variables

| Name             | Description                             | Type   | Default      |
|------------------|-----------------------------------------|--------|--------------|
| `env`            | Environment name for tagging            | string | `"dev"`      |
| `vpc_id`         | The ID of the VPC                       | string | `n/a`        |
| `subnets`        | List of subnet IDs for the ALB          | list   | `[]`         |
| `listener_port`  | The port on which the ALB listener listens | number | `80`         |

---

## 📤 Outputs

| Name            | Description                            |
|-----------------|----------------------------------------|
| `alb_arn`       | ARN of the created ALB                 |
| `alb_dns_name`  | DNS name of the created ALB            |

---

## 🚀 Example Usage

```hcl
module "lb" {
  source         = "../modules/lb"
  env            = "dev"
  vpc_id         = module.vpc.vpc_id
  subnets        = module.vpc.public_subnet_ids
  listener_port  = 80
}

