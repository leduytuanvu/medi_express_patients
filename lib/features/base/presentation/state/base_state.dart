import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/features/auth/domain/entities/auth_entity.dart';

class BaseState {
  var isLoading = false.obs;

  var warningMessage = ''.obs;
  var titleButtonWarning = ''.obs;
  var warningFunction = Rx<VoidCallback?>(null);

  var errorMessage = ''.obs;
  var titleButtonError = ''.obs;
  var errorFunction = Rx<VoidCallback?>(null);

  var auth = AuthEntity().obs;
}
