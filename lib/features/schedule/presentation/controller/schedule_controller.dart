import 'package:flutter/material.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/main/presentation/state/main_state.dart';
import 'package:medi_express_patients/features/schedule/presentation/state/schedule_state.dart';

class ScheduleController extends BaseController {
  ScheduleController({
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  final ScheduleState scheduleState = ScheduleState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Log.info("init schedule controller");
  }

  void setChooseScheduleDone(bool value) {
    scheduleState.scheduleExamDone.value = value;
  }
}
