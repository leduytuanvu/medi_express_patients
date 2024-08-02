import 'package:flutter/material.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/doctor/presentation/state/doctor_state.dart';
import 'package:medi_express_patients/features/main/presentation/state/main_state.dart';

class DoctorController extends BaseController {
  DoctorController({
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  final DoctorState doctorState = DoctorState();
}
