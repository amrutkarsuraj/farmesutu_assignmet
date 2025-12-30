import '../entity/weather_entity.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> getCurrentWeather({
    required double latitude,
    required double longitude,
  });

  Future<WeatherEntity> getWeatherByCity(String cityName);

}
