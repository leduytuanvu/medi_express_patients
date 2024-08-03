import 'package:flutter/material.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/features/auth/domain/entities/auth_entity.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/home/presentation/state/home_state.dart';
import 'package:medi_express_patients/features/main/presentation/state/main_state.dart';

class HomeController extends BaseController {
  HomeController({
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  final HomeState homeState = HomeState();

  final serchController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Log.info("init home controller");
  }

  Future<void> logout(AuthEntity authEntity) async {
    setAuth(authEntity);
  }
}
