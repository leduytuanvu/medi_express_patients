import 'package:medi_express_patients/features/home/domain/entities/health_record_entity.dart';
import 'package:medi_express_patients/features/home/domain/entities/home_examination_package_entity.dart';

abstract class HomeRepository {
  Future<List<HealthRecordEntity>> getAllHealthRecord();

  Future<List<HomeExaminationPackageEntity>> getListHomeExaminationPackage();
}
