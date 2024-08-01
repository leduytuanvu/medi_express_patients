import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final int maxRetries;

  RetryInterceptor({this.maxRetries = 3});

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 500 || err.response?.statusCode == 503) {
      final requestOptions = err.requestOptions;
      int retryCount = 0;
      while (retryCount < maxRetries) {
        retryCount++;
        try {
          final response = await Dio().request(
            requestOptions.path,
            options: Options(
              method: requestOptions.method,
              headers: requestOptions.headers,
              responseType: requestOptions.responseType,
            ),
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters,
          );
          return handler.resolve(response);
        } catch (e) {
          if (retryCount == maxRetries) {
            return handler.reject(err);
          }
        }
      }
    } else {
      return super.onError(err, handler);
    }
  }
}
