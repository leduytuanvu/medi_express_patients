import 'dart:core';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/information_doctor_entity.dart';
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

  void filterDoctorList(String query) {
    if (query.isEmpty) {
      // Reset to the original unfiltered list when the query is empty
      doctorState.listAllInformationDoctor.value =
          doctorState.listAllInformationDoctorSearch;
    } else {
      // Normalize the search query by removing diacritics
      final String normalizedQuery = removeDiacritics(query.toLowerCase());

      // Always filter from the original list
      final List<InformationDoctorEntity> filteredList =
          doctorState.listAllInformationDoctorSearch.where((doctor) {
        // Normalize the doctor's name, degree, and major
        final String normalizedName =
            removeDiacritics(doctor.name!.toLowerCase());
        final String normalizedDegree =
            removeDiacritics(doctor.degree!.toLowerCase());
        final String normalizedMajor =
            removeDiacritics(doctor.major?.toLowerCase() ?? '');

        return normalizedName.contains(normalizedQuery) ||
            normalizedDegree.contains(normalizedQuery) ||
            normalizedMajor.contains(normalizedQuery);
      }).toList();

      // Update the filtered list
      doctorState.listAllInformationDoctor.value = filteredList;
    }
  }

  void searchDoctorByName() {
    filterDoctorList(searchController.text); // Reuse the filter function
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
        doctorState.listAllInformationDoctorSearch.value = success;
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
