import 'package:medi_express_patients/features/doctor/domain/entities/doctor_by_name_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/doctor_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/doctor_information_detail_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/information_doctor_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/params/create_apointment_id_params.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/create_appointment_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/service_type_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/type_create_appointment_service_entity.dart';

abstract class DoctorRepository {
  Future<List<DoctorEntity>> getAllDoctor();

  Future<List<InformationDoctorEntity>> getAllInformationDoctor();

  Future<List<DoctorByNameEntity>> getDoctorByName(String name);

  Future<DoctorInformationDetailEntity> getDoctorInformationDetail(
      int doctorId);
  Future<List<TypeCreateAppointmentServiceEntity>>
      getTypeCreateAppointmentService();

  Future<List<ServiceTypeEntity>> getServiceType();

  Future<CreateAppointmentEntity> createAppointment(
      CreateAppointmentIdParams params);
}
