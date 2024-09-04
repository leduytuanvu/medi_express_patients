import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/features/main/presentation/state/main_state.dart';

class MainController extends BaseController {
  MainController({
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  final MainState mainState = MainState();
  final PageController pageController = PageController();

  final AuthController authController = Get.find<AuthController>();

  void changePage(int index) {
    mainState.currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Log.info("init main controller");
  }

  // Future<void> createAppointment(BuildContext context) async {
  //   authController.showLoading();
  //   Log.info("create appointment");
  //   var typeService = -1;
  //   if (mainState.typeExamAtHome.value) {
  //     typeService = 1;
  //   } else {
  //     typeService = 0;
  //   }
  //
  //   var check = true;
  //   if (mainState.dateChoose.value.isEmpty) {
  //     check = false;
  //     mainState.errorChooseDate.value = 'Vui lòng chọn ngày';
  //   } else {
  //     mainState.errorChooseDate.value = '';
  //   }
  //
  //   if (mainState.typeCreateAppointmentService.value.id == -1) {
  //     mainState.typeCreateAppointmentService.value =
  //         mainState.listTypeCreateAppointmentService.first;
  //   }
  //   // else {
  //   //   mainState.errorChooseService.value = '';
  //   // }
  //
  //   if (mainState.timeChoose.value.isEmpty) {
  //     check = false;
  //     mainState.errorChooseTime.value = 'Vui lòng chọn thời gian';
  //   } else {
  //     mainState.errorChooseTime.value = '';
  //   }
  //
  //   if (check) {
  //     List<String> times = mainState.timeChoose.value.split(' - ');
  //     var dateChoose =
  //         '${mainState.yearChoose}-${mainState.monthChoose}-${mainState.dateChoose.value}';
  //     Log.info("============= date choose:$dateChoose");
  //     final result = await createAppointmentUsecase(
  //       CreateAppointmentParams(
  //         patientID: authController.baseState.user.value.id,
  //         serviceID: typeService,
  //         serviceTypeID: mainState.typeCreateAppointmentService.value.id ?? 0,
  //         appointmentDate: dateChoose,
  //         startTime: times[0],
  //         endTime: times[1],
  //       ),
  //     );
  //     result.fold(
  //       (failure) {
  //         Log.severe("$failure");
  //         authController.showError(
  //           () => authController.clearError(),
  //           failure.message,
  //           'come_back'.tr,
  //         );
  //         Log.info(failure.toString());
  //         Log.info(failure.description.toString());
  //       },
  //       (success) async {
  //         authController.showWarning(
  //           () {
  //             Log.info("create success");
  //             authController.clearWarning();
  //             context.backScreen();
  //           },
  //           'Đặt lịch khám thành công',
  //           'Xác nhận',
  //         );
  //       },
  //     );
  //   }
  //   authController.hideLoading();
  // }
  //
  // Future<void> getTypeCreateAppointmentService() async {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     authController.showLoading();
  //   });
  //
  //   final result = await getTypeCreateAppointmentServiceUsecase(NoParams());
  //   result.fold(
  //     (failure) {
  //       Log.severe("$failure");
  //       authController.showError(
  //         () => authController.clearError(),
  //         failure.message,
  //         'come_back'.tr,
  //       );
  //     },
  //     (success) async {
  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //         mainState.listTypeCreateAppointmentService.value = success;
  //       });
  //     },
  //   );
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     authController.hideLoading();
  //   });
  // }
}
