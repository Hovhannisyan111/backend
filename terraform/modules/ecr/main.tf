resource "aws_ecr_repository" "backend" {
  name         = var.ecr_repo_name
  force_delete = true
}
data "aws_caller_identity" "current" {}

resource "aws_ecr_lifecycle_policy" "backend_policy" {
  repository = aws_ecr_repository.backend.name
  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Delete images older than 7 days"
        selection = {
          tagStatus   = "any"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 7
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "null_resource" "push_backend" {
  provisioner "local-exec" {
    command = <<EOT
        docker build -t my-backend-app:latest ${var.backend_path}
          aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com
      docker tag my-backend-app:latest ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/backend:latest
      docker push ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/backend:latest
    EOT
  }
  depends_on = [aws_ecr_repository.backend]
}
