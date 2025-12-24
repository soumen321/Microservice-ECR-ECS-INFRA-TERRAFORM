output "ecr_repository_url" {
  description = "ECR repository URL for pushing Docker images"
  value       = aws_ecr_repository.app.repository_url
}

output "ecr_repository_name" {
  description = "ECR repository name"
  value       = aws_ecr_repository.app.name
}

output "github_actions_access_key_id" {
  description = "GitHub Actions IAM Access Key ID"
  value       = aws_iam_access_key.github_actions.id
  sensitive   = true
}

output "github_actions_secret_access_key" {
  description = "GitHub Actions IAM Secret Access Key"
  value       = aws_iam_access_key.github_actions.secret
  sensitive   = true
}

output "aws_region" {
  description = "AWS region"
  value       = var.aws_region
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.main.name
}

output "load_balancer_dns" {
  description = "Load balancer DNS (if created)"
  value       = try(aws_lb.main.dns_name, "ALB not created")
}