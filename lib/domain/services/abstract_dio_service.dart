import 'package:dio/dio.dart';

abstract class AbstractDioService {
  void configureDio();
  void configureApiKey();
  Dio get dio;
}
