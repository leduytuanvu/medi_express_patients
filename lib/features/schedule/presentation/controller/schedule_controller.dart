import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/features/schedule/domain/params/create_appointment_params.dart';
import 'package:medi_express_patients/features/schedule/domain/params/get_all_schedule_params.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/create_appointment_usecase.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/get_all_schedule_usecase.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/get_schedule_result_usecase.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/get_type_create_appointment_service_usecase.dart';
import 'package:medi_express_patients/features/schedule/presentation/state/schedule_state.dart';

class ScheduleController extends BaseController {
  ScheduleController({
    required this.getAllScheduleUsecase,
    required this.getScheduleResultUsecase,
    required this.getTypeCreateAppointmentServiceUsecase,
    required this.createAppointmentUsecase,
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  final AuthController authController = Get.find<AuthController>();
  final ScheduleState scheduleState = ScheduleState();

  final GetAllScheduleUsecase getAllScheduleUsecase;
  final CreateAppointmentUsecase createAppointmentUsecase;
  final GetTypeCreateAppointmentServiceUsecase
      getTypeCreateAppointmentServiceUsecase;
  final GetScheduleResultUsecase getScheduleResultUsecase;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    DateTime now = DateTime.now();
    int currentMonth = now.month;
    int currentYear = now.year;
    int dateChoose = now.day;
    scheduleState.monthChoose.value = currentMonth.toString();
    scheduleState.yearChoose.value = currentYear.toString();
    // await getAllSchedule();
    Log.info("init schedule controller");
  }

  void setChooseScheduleDone(bool value) {
    scheduleState.scheduleExamDone.value = value;
  }

  void setTypeExamAtHome(bool value) {
    scheduleState.typeExamAtHome.value = value;
  }

  Future<void> getAllSchedule() async {
    scheduleState.scheduleExamDone.value = false;
    authController.showLoading();
    Log.info("Loading initial data...");
    final result = await getAllScheduleUsecase(
      GetAllScheduleParams(
          status: 'Approved',
          patientId: authController.baseState.user.value.id),
    );
    result.fold(
      (failure) {
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
        scheduleState.listAllSchedule.value = success;
      },
    );
    authController.hideLoading();
  }

  Future<void> createAppointment(BuildContext context) async {
    authController.showLoading();
    Log.info("create appointment");
    var typeService = -1;
    if (scheduleState.typeExamAtHome.value) {
      typeService = 1;
    } else {
      typeService = 2;
    }

    var check = true;
    if (scheduleState.dateChoose.value.isEmpty) {
      check = false;
      scheduleState.errorChooseDate.value = 'Vui lòng chọn ngày';
    } else {
      scheduleState.errorChooseDate.value = '';
    }

    if (scheduleState.typeCreateAppointmentService.value.id == -1) {
      scheduleState.typeCreateAppointmentService.value =
          scheduleState.listTypeCreateAppointmentService.first;
    }
    // else {
    //   scheduleState.errorChooseService.value = '';
    // }

    if (scheduleState.timeChoose.value.isEmpty) {
      check = false;
      scheduleState.errorChooseTime.value = 'Vui lòng chọn thời gian';
    } else {
      scheduleState.errorChooseTime.value = '';
    }

    if (check) {
      List<String> times = scheduleState.timeChoose.value.split(' - ');
      var dateChoose =
          '${scheduleState.yearChoose}-${scheduleState.monthChoose}-${scheduleState.dateChoose.value}';
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
        CreateAppointmentParams(
          patientID: authController.baseState.user.value.id,
          serviceID: scheduleState.typeCreateAppointmentService.value.id ?? 0,
          serviceTypeID: typeService,
          appointmentDate: formattedDateStr,
          startTime: times[0],
          endTime: times[1],
        ),
      );
      result.fold(
        (failure) {
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
          scheduleState.listTypeCreateAppointmentService.value = success;
        });
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.hideLoading();
    });
  }

  Future<void> getScheduleResult(String id) async {
    authController.showLoading();
    final result = await getScheduleResultUsecase(id);
    result.fold(
      (failure) {
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
        scheduleState.scheduleResult.value = success;
      },
    );
    authController.hideLoading();
  }

  Future<void> getAllScheduleDone() async {
    scheduleState.scheduleExamDone.value = true;
    authController.showLoading();
    Log.info("Loading initial data...");
    final result = await getAllScheduleUsecase(
      GetAllScheduleParams(
        status: 'Completed',
        patientId: authController.baseState.user.value.id,
      ),
    );
    result.fold(
      (failure) {
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
        scheduleState.listAllScheduleDone.value = success;
      },
    );
    authController.hideLoading();
  }
}
