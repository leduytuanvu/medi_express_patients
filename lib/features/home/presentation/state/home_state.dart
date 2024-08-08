import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/features/base/presentation/state/base_state.dart';
import 'package:medi_express_patients/features/home/domain/entities/health_record_entity.dart';

class HomeState extends BaseState {
  var listAllHealthRecord = <HealthRecordEntity>[].obs;
}
