import 'package:get/get.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/schedule_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/schedule_result_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/type_create_appointment_service_entity.dart';

class ScheduleState {
  var scheduleExamDone = false.obs;
  var typeExamAtHome = true.obs;

  var monthChoose = ''.obs;
  var yearChoose = ''.obs;
  var dateChoose = ''.obs;
  var timeChoose = ''.obs;

  var errorChooseService = ''.obs;
  var errorChooseTime = ''.obs;
  var errorChooseDate = ''.obs;

  var listAllSchedule = <ScheduleEntity>[].obs;

  var listTypeCreateAppointmentService =
      <TypeCreateAppointmentServiceEntity>[].obs;

  var listAllScheduleDone = <ScheduleEntity>[].obs;
  var typeCreateAppointmentService = TypeCreateAppointmentServiceEntity().obs;

  var scheduleResult = ScheduleResultEntity().obs;
}
