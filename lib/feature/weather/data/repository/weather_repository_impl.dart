import '../../domain/entity/weather_entity.dart';
import '../../domain/repository/weather_repository.dart';
import '../datasource/weather_remote_datasource.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<WeatherEntity> getCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    final model = await remoteDataSource.getCurrentWeather(
      latitude: latitude,
      longitude: longitude,
    );

    return WeatherEntity(
      cityName: model.cityName,
      temperature: model.temp,
      humidity: model.humidity,
      description: model.description,
      icon: model.icon,
    );
  }
  @override
  Future<WeatherEntity> getWeatherByCity(String cityName) async {
    final model = await remoteDataSource.getWeatherByCity(cityName);

    return WeatherEntity(
      cityName: model.cityName,
      temperature: model.temp,
      humidity: model.humidity,
      description: model.description,
      icon: model.icon,
    );
  }


}
