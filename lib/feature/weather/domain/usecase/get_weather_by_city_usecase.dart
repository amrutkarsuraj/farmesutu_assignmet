import '../entity/weather_entity.dart';
import '../repository/weather_repository.dart';

class GetWeatherByCityUseCase {
  final WeatherRepository repository;

  GetWeatherByCityUseCase(this.repository);

  Future<WeatherEntity> call(String cityName) {
    return repository.getWeatherByCity(cityName);
  }
}
