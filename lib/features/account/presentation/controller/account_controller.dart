import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/features/account/presentation/state/account_state.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/main/presentation/state/main_state.dart';

class AccountController extends BaseController {
  AccountController({
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  final AccountState accountState = AccountState();

  // final phoneController = TextEditingController();
  // final verifyCodeController = TextEditingController();
  // final passwordLoginController = TextEditingController();
  // final passwordRegisterController = TextEditingController();
  // final rePasswordRegisterController = TextEditingController();
  // final passwordForgotPasswordController = TextEditingController();
  // final rePasswordForgotPasswordController = TextEditingController();
  // final fullNameController = TextEditingController();
  // final emailController = TextEditingController();
  // final birthdateController = TextEditingController();
  // final genderController = TextEditingController();
  // final cityController = TextEditingController();
  // final districtController = TextEditingController();
  // final wardController = TextEditingController();
  // final addressController = TextEditingController();
  // final bhytController = TextEditingController();
  // final anotherController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Log.info("init account controller");
  }

  Future<void> initial() async {
    final AuthController authController = Get.find<AuthController>();
    var user = authController.baseState.user.value;
    if(user.name!.isNotEmpty) {
      authController.fullNameController.text = user.name!;
    }
    if(user.email!.isNotEmpty) {
      authController.emailController.text = user.email!;
    }
    if(user.birthDate!.isNotEmpty) {
      authController.birthdateController.text = user.birthDate!;
    }
    if(user.birthDate!.isNotEmpty) {
      authController.birthdateController.text = user.birthDate!;
    }
    authController.genderController.text = user.gender.toString()!;
    if(user.city!.isNotEmpty) {
      authController.cityController.text = user.city!;
    }
    if(user.district!.isNotEmpty) {
      authController.districtController.text = user.district!;
    }
    if(user.ward!.isNotEmpty) {
      authController.wardController.text = user.ward!;
    }
    if(user.street!.isNotEmpty) {
      authController.addressController.text = user.street!;
    }
    if(user.bhytCode!.isNotEmpty) {
      authController.bhytController.text = user.bhytCode!;
    }
  }
}
