import 'package:get/get.dart';
import 'package:medi_express_patients/features/base/presentation/state/base_state.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/doctor_by_name_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/doctor_information_detail_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/information_doctor_entity.dart';

class DoctorState extends BaseState {
  var search = ''.obs;
  var listAllInformationDoctor = <InformationDoctorEntity>[].obs;
  var listSearchDoctor = <DoctorByNameEntity>[].obs;
  var doctorInformationDetail = DoctorInformationDetailEntity(
    information: InformationEntity(),
    workingProcess: <WorkingProcessEntity>[],
  ).obs;
}
