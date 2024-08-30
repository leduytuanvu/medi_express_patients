import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/features/auth/domain/entities/auth_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/user_entity.dart';

class BaseState {
  var isLoading = false.obs;
  var isShowDialogCustom = false.obs;
  var widgetDialogCustom = Rxn<Widget>();

  var warningTitleButton = ''.obs;
  var warningMessage = ''.obs;
  var warningFunction = Rx<VoidCallback?>(null);

  var errorTitleButton = ''.obs;
  var errorMessage = ''.obs;
  var errorFunction = Rx<VoidCallback?>(null);

  var confirmTitleButton = ''.obs;
  var confirmMessage = ''.obs;
  var confirmFunction = Rx<VoidCallback?>(null);

  var auth = AuthEntity().obs;
  var user = UserEntity().obs;

  var listLocale = [
    Locale('vi', 'VN'),
    Locale('en', 'US'),
  ];
  var listLanguage = [
    "Tiếng Việt",
    "Tiếng Anh",
  ].obs;
  var locale = Locale('vi', 'VN').obs;
}
