import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/features/auth/domain/entities/auth_entity.dart';
import 'package:medi_express_patients/features/base/presentation/state/base_state.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';

abstract class BaseController extends GetxController {
  final BaseState baseState = BaseState();

  final ErrorHandlingService errorHandlingService;

  BaseController(this.errorHandlingService);

  void showLoading() {
    baseState.isLoading.value = true;
  }

  void hideLoading() {
    baseState.isLoading.value = false;
  }

  void showError(
    VoidCallback callback,
    String errorgMessage,
    String titleButtonError,
  ) {
    baseState.titleButtonError.value = titleButtonError;
    baseState.errorFunction.value = callback;
    baseState.errorMessage.value = errorgMessage;
  }

  void clearError() {
    baseState.titleButtonError.value = '';
    baseState.errorMessage.value = '';
    baseState.errorFunction.value = () {};
    baseState.errorMessage.value = '';
  }

  void showWarning(
    VoidCallback callback,
    String warningMessage,
    String titleButtonWarning,
  ) {
    baseState.titleButtonWarning.value = titleButtonWarning;
    baseState.warningFunction.value = callback;
    baseState.warningMessage.value = warningMessage;
  }

  void clearWarning() {
    baseState.titleButtonWarning.value = '';
    baseState.warningMessage.value = '';
    baseState.warningFunction.value = () {};
  }

  void setAccessToken(String accessToken) {
    Log.info("access token 1: ${baseState.accessToken.value.toString()}");
    baseState.accessToken.value = accessToken;
    Log.info("access token 2: ${baseState.accessToken.value.toString()}");
  }

  void setAuth(AuthEntity authEntity) {
    Log.info("Auth set 1: ${baseState.auth.value.toString()}");
    baseState.auth.value = authEntity;
    Log.info("Auth set 2: ${baseState.auth.value.toString()}");
  }

  void clearAuth() {
    baseState.auth.value = AuthEntity();
  }
}
