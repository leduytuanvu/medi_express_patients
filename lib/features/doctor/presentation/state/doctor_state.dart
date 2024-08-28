import 'package:get/get.dart';
import 'package:medi_express_patients/features/base/presentation/state/base_state.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/doctor_by_name_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/doctor_information_detail_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/information_doctor_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/type_create_appointment_service_entity.dart';

class DoctorState extends BaseState {
  var search = ''.obs;
  var listAllInformationDoctor = <InformationDoctorEntity>[].obs;
  var listAllInformationDoctorSearch = <InformationDoctorEntity>[].obs;
  var listSearchDoctor = <DoctorByNameEntity>[].obs;
  var doctorInformationDetail = DoctorInformationDetailEntity(
    information: InformationEntity(),
    workingProcess: <WorkingProcessEntity>[],
  ).obs;

  var typeCreateAppointmentService = TypeCreateAppointmentServiceEntity().obs;
  var typeExamAtHome = true.obs;
  var monthChoose = ''.obs;
  var yearChoose = ''.obs;
  var dateChoose = ''.obs;
  var timeChoose = ''.obs;

  var errorChooseService = ''.obs;
  var errorChooseTime = ''.obs;
  var errorChooseDate = ''.obs;

  var listTypeCreateAppointmentService =
      <TypeCreateAppointmentServiceEntity>[].obs;

  var doctorId = -1.obs;
}
