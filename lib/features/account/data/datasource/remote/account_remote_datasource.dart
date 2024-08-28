import 'dart:io';

import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/network/api_response.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/account/data/datasource/remote/account_api_service.dart';
import 'package:medi_express_patients/features/account/data/dto/health_metricts_dto.dart';
import 'package:medi_express_patients/features/account/data/dto/update_user_dto.dart';
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

  Future<ApiResponse<dynamic>> updateHeight(
    int patientId,
    double height,
    String createAt,
  ) async {
    Log.info("updateHeight in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await accountApiService.updateHeight(
        patientId,
        height,
        createAt,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => data,
      );
    }, 'AccountRemoteDatasource/updateHeight');
  }

  Future<ApiResponse<dynamic>> updateWeight(
    int patientId,
    double weight,
    String createAt,
  ) async {
    Log.info("updateWeight in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await accountApiService.updateHeight(
        patientId,
        weight,
        createAt,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => data,
      );
    }, 'AccountRemoteDatasource/updateWeight');
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

  Future<ApiResponse<UpdateUserDto>> updateUser(
    int gender,
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
        address,
        email,
        wardId,
        name,
        birthdate,
        bhytCode,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => UpdateUserDto.fromJson(data),
      );
    }, 'AccountRemoteDatasource/updateUser');
  }
}
