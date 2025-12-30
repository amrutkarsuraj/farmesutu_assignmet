import '../entity/forecast_entity.dart';
import '../repository/forecast_repository.dart';

class GetForecastUseCase {
  final ForecastRepository repository;

  GetForecastUseCase(this.repository);

  Future<List<ForecastEntity>> call({
    required double latitude,
    required double longitude,
  }) {
    return repository.getForecast(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
