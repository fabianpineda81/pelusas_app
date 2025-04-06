import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pelusas/config/app_enviroment.dart';
import 'package:pelusas/domain/services/abstract_dio_service.dart';

class DioServiceImple extends AbstractDioService {
  final String endPoint = "https://api.thecatapi.com/v1/";
  late final Dio _dio;

  DioServiceImple() {
    _dio = Dio(BaseOptions(
      baseUrl: endPoint,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      connectTimeout: const Duration(milliseconds: 20000),
      receiveTimeout: const Duration(milliseconds: 20000),
    ));

    configureDio();
    configureApiKey();
  }

  @override
  void configureApiKey() {
    if (AppEnvironment.apiKey.isNotEmpty) {
      _dio.options.headers["x-api-key"] = AppEnvironment.apiKey;
    } else {
      throw Exception("API Key no encontrada. Verifica el archivo .env");
    }
  }

  @override
  void configureDio() {
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, handler) {
        if (e.type == DioExceptionType.connectionTimeout) {
          debugPrint("Error: Tiempo de conexión agotado");
          return handler.reject(DioException(
            requestOptions: e.requestOptions,
            message: "Tiempo de conexión agotado",
          ));
        }

        if (e.response?.statusCode == 401) {
          debugPrint("Error: No autorizado, verifica la API key");
          throw Exception("No autorizado, verifica la API key");
        }

        return handler.next(e);
      },
    ));
  }

  @override
  Dio get dio => _dio;
}
