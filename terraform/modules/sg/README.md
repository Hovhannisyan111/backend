# Security Groups (SG) Module

This Terraform module provisions AWS Security Groups for the backend service, allowing you to control inbound and outbound traffic.

---

## 📦 Resources Created

- `aws_security_group`

---

## 📥 Input Variables

| Name        | Description                      | Type   | Default     |
|-------------|----------------------------------|--------|-------------|
| `env`       | Environment name for tagging     | string | `"dev"`     |
| `vpc_id`    | The ID of the VPC                | string | `n/a`       |
| `ingress`   | List of ingress rule objects     | list   | `[]`        |
| `egress`    | List of egress rule objects      | list   | `[]`        |
| `name`      | Name for the security group      | string | `"backend-sg"` |

> Note: The actual input variables depend on your code, adjust this if you used hardcoded rules instead.

---

## 📤 Outputs

| Name           | Description                        |
|----------------|------------------------------------|
| `security_group_id` | ID of the created security group |

---

## 🚀 Example Usage

```hcl
module "sg" {
  source   = "../modules/sg"
  env      = "dev"
  vpc_id   = module.vpc.vpc_id
  ingress  = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
