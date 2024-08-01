import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/features/base/presentation/state/base_state.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';

abstract class BaseController extends GetxController {
  final BaseState state = BaseState();

  final ErrorHandlingService errorHandlingService;

  BaseController(this.errorHandlingService);

  void setLoading(bool loading) {
    state.isLoading.value = loading;
  }

  void setError(String message) {
    state.errorMessage.value = message;
  }

  void clearError() {
    state.errorMessage.value = '';
  }

  void showWarning(
    VoidCallback callback,
    String warningMessage,
    String titleButtonWarning,
  ) {
    state.titleButtonWarning.value = titleButtonWarning;
    state.warningMessage.value = warningMessage;
    state.warningFunction.value = callback;
    state.isWarning.value = true;
  }

  void hideWarning() {
    state.titleButtonWarning.value = '';
    state.warningMessage.value = '';
    state.warningFunction.value = () {};
    state.isWarning.value = false;
  }
}
