import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_all_information_doctor_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_doctor_by_name_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_doctor_information_detail_usecase.dart';
import 'package:medi_express_patients/features/doctor/presentation/state/doctor_state.dart';

class DoctorController extends BaseController {
  DoctorController({
    required this.getAllInformationDoctorUsecase,
    required this.getDoctorInformationDetailUsecase,
    required this.getDoctorByNameUsecase,
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  final AuthController authController = Get.find<AuthController>();
  final DoctorState doctorState = DoctorState();

  final GetAllInformationDoctorUsecase getAllInformationDoctorUsecase;
  final GetDoctorInformationDetailUsecase getDoctorInformationDetailUsecase;
  final GetDoctorByNameUsecase getDoctorByNameUsecase;

  final searchController = TextEditingController();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // await getAllInformationDoctor();
    Log.info("init doctor controller");
  }

  Future<void> getAllInformationDoctor() async {
    authController.showLoading();
    Log.info("Loading initial data...");
    final result = await getAllInformationDoctorUsecase(NoParams());
    result.fold(
      (failure) {
        Log.info(failure.toString());
        Log.info(failure.description.toString());
      },
      (success) async {
        doctorState.listAllInformationDoctor.value = success;
      },
    );
    authController.hideLoading();
  }

  Future<void> getDoctorByName() async {
    authController.showLoading();
    Log.info("Loading initial data...");
    final result = await getDoctorByNameUsecase(searchController.text);
    result.fold(
      (failure) {
        Log.info(failure.toString());
        Log.info(failure.description.toString());
      },
      (success) async {
        doctorState.listSearchDoctor.value = success;
      },
    );
    authController.hideLoading();
  }

  Future<void> getDoctorInformationDetail(int doctorId) async {
    authController.showLoading();
    Log.info("Loading initial data...");
    final result = await getDoctorInformationDetailUsecase(doctorId);
    result.fold(
      (failure) {
        Log.severe("$failure");
        showError(
          () => clearError(),
          failure.message,
          'Quay lại',
        );
        Log.info(failure.toString());
        Log.info(failure.description.toString());
      },
      (success) async {
        doctorState.doctorInformationDetail.value = success;
      },
    );
    authController.hideLoading();
  }
}
