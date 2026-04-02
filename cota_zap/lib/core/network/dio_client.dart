import 'package:dio/dio.dart';
import 'package:cota_zap/core/config/app_config.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  static Dio get instance {
    // Adicionar interceptores se necessário (Ex: Logs, Auth)
    // _dio.interceptors.add(LogInterceptor(responseBody: true));
    return _dio;
  }
}
