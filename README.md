
# Weather Forcast Micro Service 


## Why need weather service
 1. Real-time weather alert
 2. Short-term forecast
 3. Heatwave/storm alert
 4. Regional weather pattern

### Weather Affect Electricity supply too
 - Solar Power
 - Wind Power
 - Storm
---------------------------------------------------

### Run locally
- uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
- curl "http://localhost:8000/api/weather?city=London"

### Docker Build and run
- setx WEATHER_API_KEY ="" [Powershell user]
- docker build -t weather-service .
- docker run -p 8000:8000 -e WEATHER_API_KEY weather-service

### Browser
- http://127.0.0.1:9000/docs

### Create infra 

- ECR - ECS - LB - SECRECT MANAGER
- github action run the workflow and tag and upload image in ecr registry
