import 'dart:io';

import 'package:get/get.dart';
import 'package:medi_express_patients/features/base/presentation/state/base_state.dart';
import 'package:medi_express_patients/features/home/domain/entities/health_record_entity.dart';
import 'package:medi_express_patients/features/home/domain/entities/home_examination_package_entity.dart';

class HomeState extends BaseState {
  var search = ''.obs;
  var listAllHealthRecord = <HealthRecordEntity>[].obs;
  var listAllHealthRecordSearch = <HealthRecordEntity>[].obs;
  var listNotification = [
    'Notification 1 (Chưa có UI)',
    'Notification 2 (Chưa có UI)',
    'Notification 3 (Chưa có UI)',
    'Notification 4 (Chưa có UI)',
    'Notification 5 (Chưa có UI)',
    'Notification 6 (Chưa có UI)',
  ].obs;
  var listAllHomeExaminationPackage = <HomeExaminationPackageEntity>[].obs;
  var imageFile = Rx<File?>(null);
}
