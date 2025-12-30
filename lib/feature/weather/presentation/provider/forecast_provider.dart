import 'package:farmsetu_assignment/feature/weather/presentation/provider/weather_provider.dart' show dioProvider;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../../../core/utils/location_service.dart';

import '../../data/datasource/forecast_remote_datasource.dart';
import '../../data/repository/forecast_repository_impl.dart';

import '../../domain/entity/forecast_entity.dart';
import '../../domain/repository/forecast_repository.dart';
import '../../domain/usecase/get_forecast_usecase.dart';
import '../../domain/usecase/get_forecast_by_city_usecase.dart';


final forecastRemoteDataSourceProvider =
Provider<ForecastRemoteDataSource>((ref) {
  return ForecastRemoteDataSourceImpl(ref.read(dioProvider));
});

final forecastRepositoryProvider =
Provider<ForecastRepository>((ref) {
  return ForecastRepositoryImpl(
    ref.read(forecastRemoteDataSourceProvider),
  );
});

final getForecastUseCaseProvider =
Provider<GetForecastUseCase>((ref) {
  return GetForecastUseCase(ref.read(forecastRepositoryProvider));
});

final getForecastByCityUseCaseProvider =
Provider<GetForecastByCityUseCase>((ref) {
  return GetForecastByCityUseCase(ref.read(forecastRepositoryProvider));
});



final forecastProvider =
AsyncNotifierProvider<ForecastNotifier, List<ForecastEntity>>(
  ForecastNotifier.new,
);

class ForecastNotifier extends AsyncNotifier<List<ForecastEntity>> {
  late final GetForecastUseCase _useCase;
  late final GetForecastByCityUseCase _useCaseByCity;

  @override
  Future<List<ForecastEntity>> build() async {
    _useCase = ref.read(getForecastUseCaseProvider);
    _useCaseByCity = ref.read(getForecastByCityUseCaseProvider);
    return [];
  }

  Future<void> fetchForecast() async {
    state = const AsyncLoading();
    try {
      final position = await LocationService.getCurrentLocation();
      final forecast = await _useCase(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      state = AsyncData(forecast);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> fetchForecastByCity(String cityName) async {
    state = const AsyncLoading();
    try {
      final forecast = await _useCaseByCity(cityName);
      state = AsyncData(forecast);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
