import '../../domain/entity/forecast_entity.dart';
import '../../domain/repository/forecast_repository.dart';
import '../datasource/forecast_remote_datasource.dart';

class ForecastRepositoryImpl implements ForecastRepository {
  final ForecastRemoteDataSource remoteDataSource;

  ForecastRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ForecastEntity>> getForecast({
    required double latitude,
    required double longitude,
  }) async {
    final models = await remoteDataSource.getForecast(
      latitude: latitude,
      longitude: longitude,
    );

    return _groupByDay(models);
  }

  @override
  Future<List<ForecastEntity>> getForecastByCity(String cityName) async {
    final models = await remoteDataSource.getForecastByCity(cityName);
    return _groupByDay(models);
  }

  List<ForecastEntity> _groupByDay(List<dynamic> models) {
    final Map<String, ForecastEntity> daily = {};

    for (final m in models) {
      final dateKey = '${m.date.year}-${m.date.month}-${m.date.day}';

      if (!daily.containsKey(dateKey)) {
        daily[dateKey] = ForecastEntity(
          date: m.date,
          temperature: m.maxTemp,
          icon: m.icon,
        );
      }
    }

    return daily.values.take(5).toList();
  }

}
