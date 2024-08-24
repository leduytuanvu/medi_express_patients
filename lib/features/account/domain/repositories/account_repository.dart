import 'dart:io';

import 'package:medi_express_patients/features/account/domain/entities/health_metricts_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/upload_avatar_entity.dart';

abstract class AccountRepository {
  Future<HealthMetricsEntity> getHealthMetrics(String patientId);
  Future<UploadAvatarEntity> uploadAvatar(File file);
}
