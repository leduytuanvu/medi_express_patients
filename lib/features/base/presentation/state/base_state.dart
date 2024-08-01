import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseState {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isWarning = false.obs;
  var warningMessage = ''.obs;
  var titleButtonWarning = ''.obs;
  var warningFunction= Rx<VoidCallback?>(null);
}
