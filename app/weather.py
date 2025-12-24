import os
import httpx
from app.models import WeatherResponse

API_URL = "http://api.openweathermap.org/data/2.5/weather"
API_KEY = os.getenv("WEATHER_API_KEY")

async def fetch_weather(city: str) -> WeatherResponse:
    params = {
        "q": city,
        "appid": API_KEY,
        "units": "metric"
    }
    async with httpx.AsyncClient() as client:
        response = await client.get(API_URL, params=params)
        data = response.json()
        weather = WeatherResponse(
            city=data["name"],
            temperature=data["main"]["temp"],
            description=data["weather"][0]["description"]
        )
        return weather