# Weather App (Flutter)

A Flutter application that displays location-based weather, a 5-day forecast, and an interactive weather map using free public APIs.

---

## Features
- Current weather (temperature, condition, humidity)
- 5-day forecast
- GPS-based location detection
- Manual city search
- Google Maps with weather overlay (temperature & precipitation)
- Error handling with retry

---

## Architecture
- Clean Architecture
- Riverpod state management

---

## APIs Used (Free)
- OpenWeatherMap (weather, forecast, map tiles)
- Google Maps SDK

---

## Setup & Run

1. Create a free OpenWeatherMap API key:  
   https://openweathermap.org/api

2. Run the app with the API key:
```bash
flutter pub get
flutter run --dart-define=WEATHER_API_KEY=YOUR_OPENWEATHER_KEY


---

## Screenshots

| Home Weather 
  -screenshots/home_weather.png
| City Search 
  -screenshots/city_search.png
| 5-Day Forecast 
  -screenshots/forecast.png
| Map with Weather Overlay 
  -screenshots/map_weather_overlay.png


## APK Download

You can download and install the Android APK from GitHub Releases:

https://github.com/amrutkarsuraj/farmesutu_assignmet/releases