import 'dart:io';

import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/network/api_response.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/account/data/datasource/remote/account_api_service.dart';
import 'package:medi_express_patients/features/account/data/dto/health_metricts_dto.dart';
import 'package:medi_express_patients/features/account/data/dto/upload_avatar_dto.dart';

class AccountRemoteDatasource {
  final AccountApiService accountApiService;

  AccountRemoteDatasource(this.accountApiService);

  Future<ApiResponse<HealthMetricsDto>> getHealthMetrics(
    String patientId,
  ) async {
    Log.info("getHealthMetrics in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await accountApiService.getHealthMetrics(patientId);
      return ApiResponse.fromJson(
        response.data!,
        (data) => HealthMetricsDto.fromJson(data),
      );
    }, 'AccountRemoteDatasource/getHealthMetrics');
  }

  Future<ApiResponse<UploadAvatarDto>> uploadAvatar(File file) async {
    Log.info("uploadAvatar in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await accountApiService.uploadAvatar(file);
      return ApiResponse.fromJson(
        response.data!,
        (data) => UploadAvatarDto.fromJson(data),
      );
    }, 'AccountRemoteDatasource/uploadAvatar');
  }

  Future<ApiResponse<HealthMetricsDto>> updateUser(
    String gender,
    String phoneNumber,
    String address,
    String email,
    int wardId,
    String name,
    String birthdate,
    String bhytCode,
  ) async {
    Log.info("updateUser in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await accountApiService.updateUser(
        gender,
        phoneNumber,
        address,
        email,
        wardId,
        name,
        birthdate,
        bhytCode,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => HealthMetricsDto.fromJson(data),
      );
    }, 'AccountRemoteDatasource/updateUser');
  }
}
