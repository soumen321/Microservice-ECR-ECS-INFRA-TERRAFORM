# infra/ecs.tf

# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-${var.environment}"
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${var.project_name}-${var.environment}"
  retention_in_days = 30
}

# ECS Task Definition - MUST BE DEFINED BEFORE SERVICE
resource "aws_ecs_task_definition" "app" {
  family                   = "${var.project_name}-${var.environment}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  
  container_definitions = jsonencode([{
    name      = "weather-service"
    image     = "${aws_ecr_repository.app.repository_url}:latest"
    cpu       = 256
    memory    = 512
    essential = true
    
    portMappings = [{
      containerPort = var.container_port
      hostPort      = var.container_port
    }]
    
    secrets = [{
      name      = "WEATHER_API_KEY"
      valueFrom = aws_secretsmanager_secret.weather_api_key.arn
    }]
    
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = aws_cloudwatch_log_group.ecs.name
        awslogs-region        = var.aws_region
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}

# ECS Service - REFERENCES THE TASK DEFINITION ABOVE
resource "aws_ecs_service" "main" {
  name            = "${var.project_name}-${var.environment}"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  
  network_configuration {
    subnets          = data.aws_subnets.default.ids
    security_groups  = [aws_security_group.ecs_service.id]
    assign_public_ip = true
  }
  
  depends_on = [
    aws_iam_role_policy_attachment.ecs_task_execution
  ]
}