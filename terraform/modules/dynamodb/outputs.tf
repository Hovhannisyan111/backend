output "table_name" {
  value = aws_dynamodb_table.backend.name
}

output "table_arn" {
  value = aws_dynamodb_table.backend.arn
}
