import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/features/home/domain/params/upload_patient_params.dart';
import 'package:medi_express_patients/features/home/domain/usecases/get_all_health_record_usecase.dart';
import 'package:medi_express_patients/features/home/domain/usecases/get_all_home_examination_package_usecase.dart';
import 'package:medi_express_patients/features/home/domain/usecases/upload_patient_usecase.dart';
import 'package:medi_express_patients/features/home/presentation/state/home_state.dart';

class HomeController extends BaseController {
  HomeController({
    required this.getAllHealthRecordUsecase,
    required this.getAllHomeExaminationPackageUsecase,
    required this.uploadPatientUsecase,
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  final AuthController authController = Get.find<AuthController>();
  final HomeState homeState = HomeState();

  final GetAllHealthRecordUsecase getAllHealthRecordUsecase;
  final GetAllHomeExaminationPackageUsecase getAllHomeExaminationPackageUsecase;
  final UploadPatientUsecase uploadPatientUsecase;

  final searchController = TextEditingController();
  final patientController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllHomeExaminationPackage();
    Log.info("init home controller");
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        homeState.imageFile.value = File(pickedFile.path);
        Log.info("OKOKOKOKOK: ${pickedFile.path}");
        // final result = await uploadAvatarUsecase(File(pickedFile.path));
        // result.fold(
        //       (failure) {
        //     Log.severe("$failure");
        //     authController.showError(
        //           () => authController.clearError(),
        //       failure.message,
        //       'Quay lại',
        //     );
        //   },
        //       (success) async {
        //     Log.severe("$success");
        //     final resultGetUserInformation =
        //     await authController.getUserInformationUsecase(NoParams());
        //     resultGetUserInformation.fold(
        //           (failureGetUserFromServer) {
        //         authController.showError(
        //               () => authController.clearError(),
        //           failureGetUserFromServer.message,
        //           'Quay lại',
        //         );
        //       },
        //           (successGetUserFromServer) async {
        //         Log.info(
        //             "successGetUserFromServer: ${successGetUserFromServer}");
        //         authController.setUser(successGetUserFromServer);
        //       },
        //     );
        //     clearError();
        //   },
        // );
        // await uploadImage(File(pickedFile.path));
      }
    } catch (e) {
      Log.info("e: ${e}");
      // Handle any errors that occur during image selection
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  Future<void> uploadPatient(BuildContext context) async {
    authController.showLoading();
    Log.info("Loading initial data...");
    final result = await uploadPatientUsecase(
      UploadPatientParams(
        file: homeState.imageFile.value!,
        nameHealthRecord: patientController.text,
        description: descriptionController.text,
        createDate: "2024-08-24T05:22:48.137Z",
      ),
    );
    result.fold(
      (failure) {
        Log.info(failure.toString());
        Log.info(failure.description.toString());
        authController.hideLoading();
      },
      (success) async {
        // homeState.listAllHealthRecord.value = success;
        authController.clearCustomDialog();
        // authController.hideLoading();
        Log.info("== success: ${success}");
      },
    );
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
