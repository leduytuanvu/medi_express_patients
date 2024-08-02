import 'package:flutter/material.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/features/account/presentation/state/account_state.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/main/presentation/state/main_state.dart';

class AccountController extends BaseController {
  AccountController({
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  final AccountState accountState = AccountState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Log.info("init account controller");
  }
}
