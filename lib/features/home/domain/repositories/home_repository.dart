import 'package:medi_express_patients/features/home/domain/entities/health_record_entity.dart';
import 'package:medi_express_patients/features/home/domain/entities/home_examination_package_entity.dart';
import 'package:medi_express_patients/features/home/domain/entities/upload_patient_entity.dart';
import 'package:medi_express_patients/features/home/domain/params/upload_patient_params.dart';

abstract class HomeRepository {
  Future<List<HealthRecordEntity>> getAllHealthRecord();

  Future<List<HomeExaminationPackageEntity>> getListHomeExaminationPackage();
  Future<UploadPatientEntity> uploadPatient(UploadPatientParams params);
}
