# Store ONLY the weather API key
resource "aws_secretsmanager_secret" "weather_api_key" {
  name = "${var.project_name}-${var.environment}-weather-api-key-v2"

   force_overwrite_replica_secret = true
  
  description = "Weather API key for ${var.project_name}"
}

# Store the actual API key value
resource "aws_secretsmanager_secret_version" "weather_api_key_value" {
  secret_id = aws_secretsmanager_secret.weather_api_key.id
  
  # Simple string (not JSON) since you only need the key
  secret_string = var.weather_api_key
}