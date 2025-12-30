import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

class DioProvider {
  static Dio createDio() {
    return Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
  }
}
