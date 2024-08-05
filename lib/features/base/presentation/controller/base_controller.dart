import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/features/auth/domain/entities/auth_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/user_entity.dart';
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
    String errorMessage,
    String titleButtonError,
  ) {
    baseState.errorTitleButton.value = titleButtonError;
    baseState.errorFunction.value = callback;
    baseState.errorMessage.value = errorMessage;
  }

  void clearError() {
    baseState.errorTitleButton.value = '';
    baseState.errorMessage.value = '';
    baseState.errorFunction.value = () {};
    baseState.errorMessage.value = '';
  }

  void showConfirm(
      VoidCallback callback,
      String confirmMessage,
      String titleButtonConfirm,
      ) {
    Log.info("confirm: $confirmMessage");
    baseState.confirmTitleButton.value = titleButtonConfirm;
    baseState.confirmFunction.value = callback;
    baseState.confirmMessage.value = confirmMessage;
  }

  void clearConfirm() {
    baseState.confirmTitleButton.value = '';
    baseState.confirmMessage.value = '';
    baseState.confirmFunction.value = () {};
    baseState.confirmMessage.value = '';
  }

  void showWarning(
    VoidCallback callback,
    String warningMessage,
    String titleButtonWarning,
  ) {
    baseState.warningTitleButton.value = titleButtonWarning;
    baseState.warningFunction.value = callback;
    baseState.warningMessage.value = warningMessage;
  }

  void clearWarning() {
    baseState.warningTitleButton.value = '';
    baseState.warningMessage.value = '';
    baseState.warningFunction.value = () {};
  }

  void setAuth(AuthEntity authEntity) {
    Log.info("Auth set 1: ${baseState.auth.value.toString()}");
    baseState.auth.value = authEntity;
    Log.info("Auth set 2: ${baseState.auth.value.toString()}");
  }

  void clearAuth() {
    baseState.auth.value = AuthEntity();
  }

  void setUser(UserEntity userEntity) {
    Log.info("Auth set 1: ${baseState.auth.value.toString()}");
    baseState.user.value = userEntity;
    Log.info("Auth set 2: ${baseState.auth.value.toString()}");
  }

  void clearUser() {
    baseState.user.value = UserEntity();
  }
}
