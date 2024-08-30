import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/storage/local_storage.dart';
import 'package:medi_express_patients/core/utils/common/constants.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/chat/presentation/controller/chat_controller.dart';

class AuthInterceptor extends Interceptor {
  final LocalStorage localStorage;
  final Dio dio;
  bool _refreshing = false;
  final List<QueuedRequest> _requestQueue = [];

  AuthInterceptor(this.localStorage, this.dio);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await localStorage.get(Constants.keyAccessToken);
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
      final refreshToken = await localStorage.get(Constants.keyRefreshToken);
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
        await localStorage.save(Constants.keyAccessToken, newAccessToken);
        await localStorage.save(Constants.keyRefreshToken, newRefreshToken);
        await localStorage.save(
            Constants.keyExpiresIn, newExpiresIn.toString());

        final AuthController authController = Get.find<AuthController>();
        authController.baseState.auth.value.accessToken = newAccessToken;

        final ChatController chatController = Get.find<ChatController>();
        chatController.connectSocket(accessToken: newAccessToken);

        _refreshing = false;
        _retryQueuedRequests(newAccessToken);
      } catch (e) {
        Log.info("Token refresh failed: $e");
        _refreshing = false;
        // Handle token refresh failure (e.g., redirect to login)
        await localStorage.clear(Constants.keyAccessToken);
        await localStorage.clear(Constants.keyRefreshToken);
        await localStorage.clear(Constants.keyExpiresIn);

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
