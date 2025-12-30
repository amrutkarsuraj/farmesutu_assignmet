import '../entity/forecast_entity.dart';

abstract class ForecastRepository {
  Future<List<ForecastEntity>> getForecast({
    required double latitude,
    required double longitude,
  });

  Future<List<ForecastEntity>> getForecastByCity(String cityName);
}
