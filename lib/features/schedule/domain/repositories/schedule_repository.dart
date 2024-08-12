import 'package:medi_express_patients/features/schedule/domain/entities/create_appointment_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/schedule_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/schedule_result_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/service_type_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/type_create_appointment_service_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/params/create_appointment_params.dart';

abstract class ScheduleRepository {
  Future<List<ScheduleEntity>> getAllSchedule(String status, int patientId);

  Future<List<TypeCreateAppointmentServiceEntity>>
      getTypeCreateAppointmentService();

  Future<List<ServiceTypeEntity>> getServiceType();

  Future<ScheduleResultEntity> getScheduleResult(String id);

  Future<CreateAppointmentEntity> createAppointment(
      CreateAppointmentParams params);
}
