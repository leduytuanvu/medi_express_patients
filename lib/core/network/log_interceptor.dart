import 'package:dio/dio.dart';
import 'package:medi_express_patients/core/config/log.dart';

class LoggingInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    Log.info('Request: ${options.method} ${options.uri}');
    Log.info('Headers: ${options.headers}');
    Log.info('Request Body: ${options.data}');
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    Log.info('Response: ${response.statusCode} ${response.requestOptions.uri}');
    Log.info('Response Data: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    Log.info('Error: ${err.response?.statusCode} ${err.requestOptions.uri}');
    Log.info('Error Message: ${err.message}');
    return super.onError(err, handler);
  }
}
