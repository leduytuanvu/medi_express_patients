import 'package:medi_express_patients/features/account/domain/entities/health_metricts_entity.dart';

abstract class AccountRepository {
  Future<HealthMetricsEntity> getHealthMetrics(String patientId);
}
