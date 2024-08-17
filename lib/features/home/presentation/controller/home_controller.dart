import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/features/home/domain/usecases/get_all_health_record_usecase.dart';
import 'package:medi_express_patients/features/home/domain/usecases/get_all_home_examination_package_usecase.dart';
import 'package:medi_express_patients/features/home/presentation/state/home_state.dart';

class HomeController extends BaseController {
  HomeController({
    required this.getAllHealthRecordUsecase,
    required this.getAllHomeExaminationPackageUsecase,
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  final AuthController authController = Get.find<AuthController>();
  final HomeState homeState = HomeState();

  final GetAllHealthRecordUsecase getAllHealthRecordUsecase;
  final GetAllHomeExaminationPackageUsecase getAllHomeExaminationPackageUsecase;

  final searchController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllHomeExaminationPackage();
    Log.info("init home controller");
  }

  Future<void> getAllHealthRecord() async {
    authController.showLoading();
    Log.info("Loading initial data...");
    final result = await getAllHealthRecordUsecase(NoParams());
    result.fold(
      (failure) {
        Log.info(failure.toString());
        Log.info(failure.description.toString());
      },
      (success) async {
        homeState.listAllHealthRecord.value = success;
      },
    );
    authController.hideLoading();
  }

  Future<void> getAllHomeExaminationPackage() async {
    authController.showLoading();
    final result = await getAllHomeExaminationPackageUsecase(NoParams());
    result.fold(
      (failure) {
        Log.info(failure.toString());
        Log.info(failure.description.toString());
      },
      (success) async {
        Log.info("suceess: $success");
        homeState.listAllHomeExaminationPackage.value = success;
      },
    );
    authController.hideLoading();
  }
}
