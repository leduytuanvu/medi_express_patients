import 'package:get/get.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/schedule_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/schedule_result_entity.dart';

class ScheduleState {
  var scheduleExamDone = false.obs;
  var typeExamAtHome = true.obs;

  var monthChoose = ''.obs;
  var yearChoose = ''.obs;
  var dateChoose = ''.obs;
  var timeChoose = ''.obs;

  var listAllSchedule = <ScheduleEntity>[].obs;
  var listAllScheduleDone = <ScheduleEntity>[].obs;

  var scheduleResult = ScheduleResultEntity().obs;
}
