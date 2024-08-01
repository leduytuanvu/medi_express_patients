import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medi_express_patients/core/network/auth_interceptor.dart';
import 'package:medi_express_patients/core/network/cache_interceptor.dart';
import 'package:medi_express_patients/core/network/log_interceptor.dart';
import 'package:medi_express_patients/core/network/retry_interceptor.dart';

class ApiClient {
  final Dio dio;

  ApiClient(String baseUrl) : dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    dio.interceptors.addAll([
      AuthInterceptor(const FlutterSecureStorage(), dio),
      CacheInterceptor(),
      LoggingInterceptor(),
      RetryInterceptor(),
    ]);
  }

  Dio get client => dio;
}
