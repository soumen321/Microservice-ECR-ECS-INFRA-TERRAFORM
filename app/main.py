from fastapi import FastAPI, Request,Query
from slowapi import Limiter
from slowapi.util import get_remote_address
from slowapi.errors import RateLimitExceeded
from fastapi.responses import JSONResponse
from slowapi.middleware import SlowAPIMiddleware
import pybreaker

from dotenv import load_dotenv
load_dotenv() 

from app.weather import fetch_weather
from app.models import WeatherResponse

app = FastAPI(title="Weather Service")

#Rate Limiter
limiter = Limiter(key_func=get_remote_address)
app.state.limiter = limiter
app.add_middleware(SlowAPIMiddleware)

#Circuit Breaker
circuit_breaker = pybreaker.CircuitBreaker(fail_max=5, reset_timeout=10)

@app.exception_handler(RateLimitExceeded)
async def rate_limit_handler(request: Request, exc: RateLimitExceeded):
    return JSONResponse(
        status_code=429,
        content={"message": "Rate limit exceeded. Try again later."},
    )
    
@app.get("/api/weather", response_model=WeatherResponse)
@limiter.limit("5/minute")

async def get_weather(
    request: Request,  # <-- add this
    city: str = Query(..., description="City name, e.g., London"),
):

    try:
        return await circuit_breaker.call(fetch_weather, city)
    except pybreaker.CircuitBreakerError:
        return WeatherResponse(
            city=city,  
            temperature=0.0,  
            description="Service unavailable due to high failure rate." 
        )