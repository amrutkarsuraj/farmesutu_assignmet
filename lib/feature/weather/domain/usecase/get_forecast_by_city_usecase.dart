import '../entity/forecast_entity.dart';
import '../repository/forecast_repository.dart';

class GetForecastByCityUseCase {
  final ForecastRepository repository;

  GetForecastByCityUseCase(this.repository);

  Future<List<ForecastEntity>> call(String cityName) {
    return repository.getForecastByCity(cityName);
  }
}
