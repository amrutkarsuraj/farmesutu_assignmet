import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/utils/location_service.dart';
import '../../domain/entity/weather_entity.dart';
import '../../domain/usecase/get_weather_by_city_usecase.dart';
import '../../domain/usecase/get_weather_usecase.dart';
import '../../domain/repository/weather_repository.dart';
import '../../data/datasource/weather_remote_datasource.dart';
import '../../data/repository/weather_repository_impl.dart';


final dioProvider = Provider((ref) {
  return DioProvider.createDio();
});

final weatherRemoteDataSourceProvider =
Provider<WeatherRemoteDataSource>((ref) {
  return WeatherRemoteDataSourceImpl(ref.read(dioProvider));
});

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepositoryImpl(
    ref.read(weatherRemoteDataSourceProvider),
  );
});

final getWeatherUseCaseProvider = Provider<GetWeatherUseCase>((ref) {
  return GetWeatherUseCase(ref.read(weatherRepositoryProvider));
});

final getWeatherByCityUseCaseProvider =
Provider<GetWeatherByCityUseCase>((ref) {
  return GetWeatherByCityUseCase(ref.read(weatherRepositoryProvider));
});


final weatherProvider =
AsyncNotifierProvider<WeatherNotifier, WeatherEntity?>(
    WeatherNotifier.new);

class WeatherNotifier extends AsyncNotifier<WeatherEntity?> {
  late final GetWeatherUseCase _useCase;
  late final GetWeatherByCityUseCase _useCaseByCity;

  @override
  Future<WeatherEntity?> build() async {
    _useCase = ref.read(getWeatherUseCaseProvider);
    _useCaseByCity = ref.read(getWeatherByCityUseCaseProvider);
    return null;
  }


  Future<void> fetchWeather() async {
    state = const AsyncLoading();

    try {
      final position = await LocationService.getCurrentLocation();

      final weather = await _useCase(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      state = AsyncData(weather);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
  Future<void> fetchWeatherByCity(String cityName) async {
    state = const AsyncLoading();
    try {
      final weather = await _useCaseByCity(cityName);
      state = AsyncData(weather);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

}
