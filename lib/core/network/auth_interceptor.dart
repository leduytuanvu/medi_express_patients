import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medi_express_patients/core/utils/comon/constants.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;
  final Dio dio;

  AuthInterceptor(this.secureStorage, this.dio);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await secureStorage.read(key: Constants.keyAccessToken);
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    // Handle token expiration or invalid token errors if needed
    if (err.response?.statusCode == 401) {
      final refreshToken =
          await secureStorage.read(key: Constants.keyRefreshToken);

      if (refreshToken == null) {
        // Handle case where refresh token is not available
        return super.onError(err, handler);
      }

      try {
        final refreshResponse = await dio.post('/refresh-token', data: {
          'refresh_token': refreshToken,
        });

        final newToken = refreshResponse.data['access_token'];
        await secureStorage.write(
          key: Constants.keyAccessToken,
          value: newToken,
        );

        final requestOptions = err.requestOptions;
        requestOptions.headers['Authorization'] = 'Bearer $newToken';

        final retryResponse = await dio.request(
          requestOptions.path,
          options: Options(
            method: requestOptions.method,
            headers: requestOptions.headers,
            responseType: requestOptions.responseType,
          ),
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
        );

        return handler.resolve(retryResponse);
      } catch (e) {
        return super.onError(err, handler);
      }
    } else {
      return super.onError(err, handler);
    }
  }
}
