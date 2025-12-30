import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../model/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather({
    required double latitude,
    required double longitude,
  });

  Future<WeatherModel> getWeatherByCity(String cityName);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSourceImpl(this.dio);

  @override
  Future<WeatherModel> getCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.weather,
        queryParameters: {
          'lat': latitude,
          'lon': longitude,
          'units': 'metric',
          'appid': const String.fromEnvironment('WEATHER_API_KEY'),
        },
      );

      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    }
  }

  @override
  Future<WeatherModel> getWeatherByCity(String cityName) async {
    try {
      final response = await dio.get(
        ApiConstants.weather,
        queryParameters: {
          'q': cityName,
          'units': 'metric',
          'appid': const String.fromEnvironment('WEATHER_API_KEY'),
        },
      );

      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    }
  }

  String _mapDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Connection timeout. Please try again.';
    }

    if (e.response?.statusCode == 404) {
      return 'Please enter a valid city name';
    }

    if (e.response?.statusCode == 401) {
      return 'Invalid API key';
    }

    return 'Failed to fetch weather data';
  }
}
