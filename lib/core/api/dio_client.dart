import 'package:dio/dio.dart';
import '../utils/constants.dart';

class DioClient {
  final Dio _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: AppConstants.apiBaseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
          ),
        );

  Dio get dio => _dio;
}
