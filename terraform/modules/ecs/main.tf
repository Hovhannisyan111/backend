resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "AWSTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "backend_task_role" {
  name = var.task_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "backend_task_policy" {
  name = var.task_policy_name
  role = aws_iam_role.backend_task_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:Scan",
        "dynamodb:Query"
      ],
      Resource = "arn:aws:dynamodb:*:*:table/${var.dynamodb_table_name}"
    }]
  })
}

resource "aws_ecs_task_definition" "backend" {
  family                   = "backend-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.backend_task_role.arn
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name         = var.backend_container_name
      image        = var.backend_ecr_url
      cpu          = 256
      memory       = 512
      essential    = true
      portMappings = [{ containerPort = 80 }]
      environment = [
        {
          name  = "DYNAMODB_TABLE",
          value = var.dynamodb_table_name
        },
        {
          name  = "AWS_REGION",
          value = var.aws_region
        }
      ]
    }
  ])
}
