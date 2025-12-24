# This file contains POC-specific configurations
# Remove or modify when moving to production

# Override any variables for POC
locals {
  # Add any POC-specific locals here
  tags = {
    Environment = "poc"
    ManagedBy   = "devopseng"
    Project     = var.project_name
    POC         = "true"
  }
}