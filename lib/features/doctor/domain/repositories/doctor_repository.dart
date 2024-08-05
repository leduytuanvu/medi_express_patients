import 'package:medi_express_patients/features/doctor/domain/entities/doctor_entity.dart';

abstract class DoctorRepository {
  Future<List<DoctorEntity>> getAllDoctor();
}