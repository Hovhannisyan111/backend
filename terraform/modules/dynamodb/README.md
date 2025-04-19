# DynamoDB Module

This Terraform module provisions an **AWS DynamoDB table** with on-demand billing mode (PAY_PER_REQUEST). It supports basic configuration with a customizable hash key and table name.

---

## 📦 Resources Created

- `aws_dynamodb_table`

---

## 📥 Input Variables

| Name         | Description                            | Type   | Default       |
|--------------|----------------------------------------|--------|---------------|
| `table_name` | Name of the DynamoDB table             | string | `"prod_table"`|
| `hash_key`   | Primary key (partition key) for the table | string | `""` (empty)  |

---

## 📤 Outputs

| Name         | Description                          |
|--------------|--------------------------------------|
| `table_name` | The name of the DynamoDB table       |
| `table_arn`  | The ARN of the DynamoDB table        |

---

## 🚀 Example Usage

```hcl
module "dynamodb" {
  source     = "../modules/dynamodb"
  table_name = "backend_sessions"
  hash_key   = "session_id"
}

