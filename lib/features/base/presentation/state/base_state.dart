import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseState {
  var isLoading = false.obs;

  var warningMessage = ''.obs;
  var titleButtonWarning = ''.obs;
  var warningFunction = Rx<VoidCallback?>(null);

  var errorMessage = ''.obs;
  var titleButtonError = ''.obs;
  var errorFunction = Rx<VoidCallback?>(null);

  var accessToken = ''.obs;
  var refreshToken = ''.obs;
  var expireIn = ''.obs;
}
