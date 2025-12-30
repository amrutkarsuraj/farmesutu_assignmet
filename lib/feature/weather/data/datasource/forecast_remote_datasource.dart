import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../model/forecast_model.dart';

abstract class ForecastRemoteDataSource {
  Future<List<ForecastModel>> getForecast({
    required double latitude,
    required double longitude,
  });

  Future<List<ForecastModel>> getForecastByCity(String cityName);
}

class ForecastRemoteDataSourceImpl implements ForecastRemoteDataSource {
  final Dio dio;

  ForecastRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ForecastModel>> getForecast({
    required double latitude,
    required double longitude,
  }) async {
    final response = await dio.get(
      ApiConstants.forecast,
      queryParameters: {
        'lat': latitude,
        'lon': longitude,
        'units': 'metric',
        'appid': const String.fromEnvironment('WEATHER_API_KEY'),
      },
    );

    final List list = response.data['list'];
    return list.map((e) => ForecastModel.fromJson(e)).toList();
  }

  @override
  Future<List<ForecastModel>> getForecastByCity(String cityName) async {
    final response = await dio.get(
      ApiConstants.forecast,
      queryParameters: {
        'q': cityName,
        'units': 'metric',
        'appid': const String.fromEnvironment('WEATHER_API_KEY'),
      },
    );

    final List list = response.data['list'];
    return list.map((e) => ForecastModel.fromJson(e)).toList();
  }
}
