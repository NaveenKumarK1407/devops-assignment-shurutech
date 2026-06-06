
# ECS Cluster


resource "aws_ecs_cluster" "main" {
  name = "${var.devops-assignment}-cluster"
}


# ECS Execution Role


resource "aws_iam_role" "ecs_execution_role" {
  name = "${var.devops-assignment}-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}


# ECS Execution Policy

resource "aws_iam_role_policy_attachment" "ecs_execution" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


# CloudWatch Logs


resource "aws_cloudwatch_log_group" "ecs" {
  name = "/ecs/${var.devops-assignment}"
}


# API Task Definition


resource "aws_ecs_task_definition" "api" {
  family                   = "api"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  cpu    = 256
  memory = 512

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  container_definitions = file("${path.module}/task-definitions/api.json.tpl")
}


# Orders Task Definition


resource "aws_ecs_task_definition" "orders" {
  family                   = "orders"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  cpu    = 256
  memory = 512

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  container_definitions = file("${path.module}/task-definitions/orders.json.tpl")
}


# Inventory Task Definition


resource "aws_ecs_task_definition" "inventory" {
  family                   = "inventory"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  cpu    = 256
  memory = 512

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  container_definitions = file("${path.module}/task-definitions/inventory.json.tpl")
}

# API ECS Service


resource "aws_ecs_service" "api" {
  name            = "api"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.api.arn

  desired_count = 1
  launch_type   = "FARGATE"

  network_configuration {
    subnets = [
      aws_subnet.private.id
    ]

    security_groups = [
      aws_security_group.ecs_sg.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.api.arn
    container_name   = "api"
    container_port   = 8080
  }
}


# Orders ECS Service


resource "aws_ecs_service" "orders" {
  name            = "orders"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.orders.arn

  desired_count = 1
  launch_type   = "FARGATE"

  network_configuration {
    subnets = [
      aws_subnet.private.id
    ]

    security_groups = [
      aws_security_group.ecs_sg.id
    ]
  }
}


# Inventory ECS Service


resource "aws_ecs_service" "inventory" {
  name            = "inventory"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.inventory.arn

  desired_count = 1
  launch_type   = "FARGATE"

  network_configuration {
    subnets = [
      aws_subnet.private.id
    ]

    security_groups = [
      aws_security_group.ecs_sg.id
    ]
  }
}