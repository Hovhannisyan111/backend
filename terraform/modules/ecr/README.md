# ECR (Elastic Container Registry) Module

This Terraform module provisions an **AWS Elastic Container Registry (ECR)** for the backend application and automates building and pushing the Docker image during provisioning using a `null_resource` with `local-exec`.

---

## 📦 Resources Created

- `aws_ecr_repository`
- `aws_ecr_lifecycle_policy`
- `null_resource` (for building and pushing Docker image)

---

## 🔄 Lifecycle Policy

The repository is configured with a lifecycle policy that:

- Deletes **all images** pushed more than **7 days ago**, regardless of tags.

---

## 📥 Input Variables

| Name            | Description                                  | Type   | Default         |
|-----------------|----------------------------------------------|--------|-----------------|
| `env`           | Environment name for tagging (optional)      | string | `"dev"`         |
| `region`        | AWS region to deploy to                      | string | `"eu-central-1"`|
| `backend_path`  | Local path to the Docker context             | string | `""`            |
| `ecr_repo_name` | Name of the ECR repository                   | string | `"backend"`     |

---

## 📤 Outputs

| Name              | Description                              |
|-------------------|------------------------------------------|
| `backend_ecr_url` | URL of the ECR repository                |

---

## 🚀 Example Usage

```hcl
module "ecr" {
  source         = "../modules/ecr"
  region         = "eu-central-1"
  backend_path   = "../../docker"
  ecr_repo_name  = "backend"
}

