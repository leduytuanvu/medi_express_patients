import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/utils/common/constants.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;
  final Dio dio;
  bool _refreshing = false;
  final List<QueuedRequest> _requestQueue = [];

  AuthInterceptor(this.secureStorage, this.dio);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await secureStorage.read(key: Constants.keyAccessToken);
    Log.info("Access Token: $accessToken");
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options); // Continue with the request
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    Log.info("Error occurred: ${err.response?.statusCode}");
    if (err.response?.statusCode == 401) {
      final refreshToken =
          await secureStorage.read(key: Constants.keyRefreshToken);
      Log.info("Refresh Token: $refreshToken");

      if (refreshToken == null) {
        Log.info("No refresh token available");
        handler.next(err); // Pass the error forward
        return;
      }

      if (_refreshing) {
        Log.info("Already refreshing token, queueing request");
        _requestQueue.add(QueuedRequest(err.requestOptions, handler));
        return;
      }

      _refreshing = true;

      try {
        _requestQueue.add(QueuedRequest(err.requestOptions, handler));
        Log.info("Attempting to refresh token");
        final refreshResponse =
            await dio.post('/mediexpress/refreshToken', data: {
          'refreshToken': refreshToken,
        });

        final newAccessToken = refreshResponse.data['data']['AccessToken'];
        final newRefreshToken = refreshResponse.data['data']['RefreshToken'];
        final newExpiresIn = refreshResponse.data['data']['ExpiresIn'];
        Log.info("New Access Token: $newAccessToken");
        Log.info("New Refresh Token: $newRefreshToken");
        Log.info("New Expires In: $newExpiresIn");

        // Update the tokens in secure storage
        await secureStorage.write(
            key: Constants.keyAccessToken, value: newAccessToken);
        await secureStorage.write(
            key: Constants.keyRefreshToken, value: newRefreshToken);
        await secureStorage.write(
            key: Constants.keyExpiresIn, value: newExpiresIn.toString());

        _refreshing = false;
        _retryQueuedRequests(newAccessToken);
      } catch (e) {
        Log.info("Token refresh failed: $e");
        _refreshing = false;
        // Handle token refresh failure (e.g., redirect to login)
        await secureStorage.delete(key: Constants.keyAccessToken);
        await secureStorage.delete(key: Constants.keyRefreshToken);
        await secureStorage.delete(key: Constants.keyExpiresIn);

        handler.next(err); // Pass the error forward
      }
    } else {
      handler.next(err); // Pass the error forward
    }
  }

  void _retryQueuedRequests(String newAccessToken) {
    Log.info("Retrying queued requests: ${_requestQueue.length}");

    for (var queued in _requestQueue) {
      Log.info("Retrying request ${queued.requestOptions.uri}");
      queued.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
      dio.fetch(queued.requestOptions).then((response) {
        queued.handler.resolve(response);
      }).catchError((e) {
        queued.handler.reject(e);
      });
    }
    _requestQueue.clear();
  }
}

class QueuedRequest {
  final RequestOptions requestOptions;
  final ErrorInterceptorHandler handler;

  QueuedRequest(this.requestOptions, this.handler);
}
