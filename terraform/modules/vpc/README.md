# VPC Module

This Terraform module provisions a **Virtual Private Cloud (VPC)** in AWS with the following components:

- VPC with a configurable CIDR block
- Internet Gateway (IGW)
- Public Subnets across multiple Availability Zones
- Route Table and Route Table Associations

---

## 📦 Resources Created

- `aws_vpc`
- `aws_internet_gateway`
- `aws_subnet` (public)
- `aws_route_table` (public)
- `aws_route_table_association`

---

## 📥 Input Variables

| Name                  | Description                                     | Type    | Default                  |
|-----------------------|-------------------------------------------------|---------|--------------------------|
| `cidr_block`          | CIDR block for the VPC                          | string  | `"10.0.0.0/16"`          |
| `env`                 | Environment name used for naming resources      | string  | `"dev"`                  |
| `public_subnet_cidrs` | List of CIDR blocks for the public subnets      | list    | `["10.0.1.0/24", "10.0.2.0/24"]` |

---

## 📤 Outputs

| Name                | Description                       |
|---------------------|-----------------------------------|
| `vpc_id`            | The ID of the created VPC         |
| `public_subnet_ids` | List of IDs for the public subnets |

---

## 🚀 Example Usage

```hcl
module "vpc" {
  source              = "../modules/vpc"
  cidr_block          = "10.0.0.0/16"
  env                 = "prod"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
}
