variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "myapp"
}

variable "environment" {
  description = "Environment (dev, staging, prod, poc)"
  type        = string
  default     = "poc"
}

variable "container_port" {
  description = "Port your container listens on"
  type        = number
  default     = 8080
}

variable "weather_api_key" {
  description = "Weather API key for initial secret value"
  type        = string
  default     = "dummy-key-change-me-later"
  sensitive   = true
}