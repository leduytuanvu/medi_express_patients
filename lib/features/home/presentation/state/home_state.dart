import 'dart:io';

import 'package:get/get.dart';
import 'package:medi_express_patients/features/base/presentation/state/base_state.dart';
import 'package:medi_express_patients/features/home/domain/entities/health_record_entity.dart';
import 'package:medi_express_patients/features/home/domain/entities/home_examination_package_entity.dart';

class HomeState extends BaseState {
  var listAllHealthRecord = <HealthRecordEntity>[].obs;
  var listNotification = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
  ].obs;
  var listAllHomeExaminationPackage = <HomeExaminationPackageEntity>[].obs;
  var imageFile = Rx<File?>(null);
}
