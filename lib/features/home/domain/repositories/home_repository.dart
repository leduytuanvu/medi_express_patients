import 'package:medi_express_patients/features/doctor/domain/entities/doctor_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/doctor_information_detail_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/information_doctor_entity.dart';
import 'package:medi_express_patients/features/home/domain/entities/health_record_entity.dart';

abstract class HomeRepository {
  Future<List<HealthRecordEntity>> getAllHealthRecord();
}
