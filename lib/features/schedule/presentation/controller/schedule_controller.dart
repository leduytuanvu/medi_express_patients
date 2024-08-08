import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/get_all_schedule_usecase.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/get_schedule_result_usecase.dart';
import 'package:medi_express_patients/features/schedule/presentation/state/schedule_state.dart';

class ScheduleController extends BaseController {
  ScheduleController({
    required this.getAllScheduleUsecase,
    required this.getScheduleResultUsecase,
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  final AuthController authController = Get.find<AuthController>();
  final ScheduleState scheduleState = ScheduleState();

  final GetAllScheduleUsecase getAllScheduleUsecase;
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
    final result = await getAllScheduleUsecase('Pending');
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
        scheduleState.listAllSchedule.value = success;
      },
    );
    authController.hideLoading();
  }

  Future<void> getScheduleResult(String id) async {
    authController.showLoading();
    final result = await getScheduleResultUsecase(id);
    result.fold(
      (failure) {
        Log.severe("$failure");
        authController.showError(
          () => clearError(),
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
    final result = await getAllScheduleUsecase('Completed');
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
        scheduleState.listAllScheduleDone.value = success;
      },
    );
    authController.hideLoading();
  }
}
