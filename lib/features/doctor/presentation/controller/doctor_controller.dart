import 'dart:core';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/information_doctor_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/params/create_apointment_id_params.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/create_appointment_id_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_all_information_doctor_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_doctor_by_name_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_doctor_information_detail_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_type_create_appointment_service_usecase.dart';
import 'package:medi_express_patients/features/doctor/presentation/state/doctor_state.dart';

class DoctorController extends BaseController {
  DoctorController({
    required this.getAllInformationDoctorUsecase,
    required this.getDoctorInformationDetailUsecase,
    required this.getDoctorByNameUsecase,
    required this.getTypeCreateAppointmentServiceUsecase,
    required this.createAppointmentUsecase,
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  final AuthController authController = Get.find<AuthController>();
  final DoctorState doctorState = DoctorState();

  final GetAllInformationDoctorUsecase getAllInformationDoctorUsecase;
  final GetDoctorInformationDetailUsecase getDoctorInformationDetailUsecase;
  final GetDoctorByNameUsecase getDoctorByNameUsecase;
  final CreateAppointmentIdUsecase createAppointmentUsecase;
  final GetTypeCreateAppointmentServiceIdUsecase
      getTypeCreateAppointmentServiceUsecase;

  final searchController = TextEditingController();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // await getAllInformationDoctor();
    Log.info("init doctor controller");
  }

  void setTypeExamAtHome(bool value) {
    doctorState.typeExamAtHome.value = value;
  }

  Future<void> createAppointment(BuildContext context, int doctorId) async {
    authController.showLoading();
    Log.info("create appointment");
    var typeService = -1;
    if (doctorState.typeExamAtHome.value) {
      typeService = 1;
    } else {
      typeService = 2;
    }

    var check = true;
    if (doctorState.dateChoose.value.isEmpty) {
      check = false;
      doctorState.errorChooseDate.value = 'Vui lòng chọn ngày';
    } else {
      doctorState.errorChooseDate.value = '';
    }

    if (doctorState.typeCreateAppointmentService.value.id == -1) {
      doctorState.typeCreateAppointmentService.value =
          doctorState.listTypeCreateAppointmentService.first;
    }
    // else {
    //   scheduleState.errorChooseService.value = '';
    // }

    if (doctorState.timeChoose.value.isEmpty) {
      check = false;
      doctorState.errorChooseTime.value = 'Vui lòng chọn thời gian';
    } else {
      doctorState.errorChooseTime.value = '';
    }

    if (check) {
      List<String> times = doctorState.timeChoose.value.split(' - ');
      var dateChoose =
          '${doctorState.yearChoose}-${doctorState.monthChoose}-${doctorState.dateChoose.value}';
      // Split the string by '-'
      final parts = dateChoose.split('-');

      // Extract year, month, and day from the split parts
      final year = parts[0];
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);

      // Format month and day to be two digits
      var formattedMonth = month.toString().padLeft(2, '0');
      var formattedDay = day.toString().padLeft(2, '0');

      // Construct the final formatted date string
      final formattedDateStr = '$year-$formattedMonth-$formattedDay';
      Log.info(
          "+++++++++++++++++++++++++++++++++++++ formattedMonth $formattedMonth, formattedDay $formattedDay");
      Log.info(
          "============= date choose:$formattedDateStr, tmp service: $typeService");
      final result = await createAppointmentUsecase(
        CreateAppointmentIdParams(
          doctorId: doctorId,
          patientID: authController.baseState.user.value.id,
          serviceID: doctorState.typeCreateAppointmentService.value.id ?? 0,
          serviceTypeID: typeService,
          appointmentDate: formattedDateStr,
          startTime: times[0],
          endTime: times[1],
        ),
      );
      result.fold(
        (failure) {
          Log.info('222222222222222222 ' + failure.toString());
          Log.severe("$failure");
          authController.showError(
            () => authController.clearError(),
            failure.message,
            'Quay lại',
          );
          Log.info(failure.toString());
          Log.info(failure.description.toString());
        },
        (success) async {
          Log.info('11111111111111111 ' + success.toString());
          if (success.id == -1) {
            authController.showError(
              () => authController.clearError(),
              'Lịch hẹn trùng thời gian',
              'Quay lại',
            );
          } else {
            authController.showWarning(
              () {
                Log.info("create success");
                authController.clearWarning();
                context.backScreen();
              },
              'Đặt lịch khám thành công',
              'Xác nhận',
            );
          }
        },
      );
    }
    authController.hideLoading();
  }

  Future<void> getTypeCreateAppointmentService() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.showLoading();
    });

    final result = await getTypeCreateAppointmentServiceUsecase(NoParams());
    result.fold(
      (failure) {
        Log.severe("$failure");
        authController.showError(
          () => authController.clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) async {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          doctorState.listTypeCreateAppointmentService.value = success;
        });
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.hideLoading();
    });
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
