import '../entity/weather_entity.dart';
import '../repository/weather_repository.dart';

class GetWeatherUseCase {
  final WeatherRepository repository;

  GetWeatherUseCase(this.repository);

  Future<WeatherEntity> call({
    required double latitude,
    required double longitude,
  }) {
    return repository.getCurrentWeather(
      latitude: latitude,
      longitude: longitude,
    );
  }
}

