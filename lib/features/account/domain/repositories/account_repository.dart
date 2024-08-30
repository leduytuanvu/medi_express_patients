import 'dart:io';

import 'package:medi_express_patients/core/network/api_response.dart';
import 'package:medi_express_patients/features/account/domain/entities/acid_uric_detail_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/blood_pressure_detail_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/blood_sugar_detail_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/health_metricts_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/heart_rate_detail_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/height_detail_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/spo2_detail_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/temperature_detail_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/update_user_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/upload_avatar_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/weight_detail_entity.dart';

abstract class AccountRepository {
  Future<HealthMetricsEntity> getHealthMetrics(String patientId);
  Future<ApiResponse<dynamic>> updateHeight(
    int patientId,
    double height,
    String createAt,
  );

  Future<List<HeightDetailEntity>> getListHeight(
    String start,
    String end,
    String offset,
    String limit,
  );

  Future<List<AcidUricDetailEntity>> getListAcidUric(
    String start,
    String end,
    String offset,
    String limit,
  );

  Future<List<Spo2DetailEntity>> getListSpo2(
    String start,
    String end,
    String offset,
    String limit,
  );

  Future<List<BloodPressureDetailEntity>> getListBloodPressure(
    String start,
    String end,
    String offset,
    String limit,
  );

  Future<List<BloodSugarDetailEntity>> getListBloodSugar(
    String start,
    String end,
    String offset,
    String limit,
  );

  Future<List<HeartRateDetailEntity>> getListHeartRate(
    String start,
    String end,
    String offset,
    String limit,
  );

  Future<List<TemperatureDetailEntity>> getListTemperature(
    String start,
    String end,
    String offset,
    String limit,
  );

  Future<List<WeightDetailEntity>> getListWeight(
    String start,
    String end,
    String offset,
    String limit,
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
