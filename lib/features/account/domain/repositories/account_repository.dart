import 'dart:io';

import 'package:medi_express_patients/core/network/api_response.dart';
import 'package:medi_express_patients/features/account/domain/entities/health_metricts_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/update_user_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/upload_avatar_entity.dart';

abstract class AccountRepository {
  Future<HealthMetricsEntity> getHealthMetrics(String patientId);
  Future<ApiResponse<dynamic>> updateHeight(
    int patientId,
    double height,
    String createAt,
  );

  Future<ApiResponse<dynamic>> updateWeight(
    int patientId,
    double weight,
    String createAt,
  );

  Future<UpdateUserEntity> updateUser(
    int gender,
    String address,
    String email,
    int wardId,
    String name,
    String birthdate,
    String bhytCode,
  );
  Future<UploadAvatarEntity> uploadAvatar(File file);
}
