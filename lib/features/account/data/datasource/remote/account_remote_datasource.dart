import 'dart:io';

import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/network/api_response.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/account/data/datasource/remote/account_api_service.dart';
import 'package:medi_express_patients/features/account/data/dto/acid_uric_detail_dto.dart';
import 'package:medi_express_patients/features/account/data/dto/blood_pressure_detail_dto.dart';
import 'package:medi_express_patients/features/account/data/dto/blood_sugar_detail_dto.dart';
import 'package:medi_express_patients/features/account/data/dto/health_metricts_dto.dart';
import 'package:medi_express_patients/features/account/data/dto/heart_rate_detail_dto.dart';
import 'package:medi_express_patients/features/account/data/dto/height_detail_dto.dart';
import 'package:medi_express_patients/features/account/data/dto/spo2_detail_dto.dart';
import 'package:medi_express_patients/features/account/data/dto/temperature_detail_dto.dart';
import 'package:medi_express_patients/features/account/data/dto/update_user_dto.dart';
import 'package:medi_express_patients/features/account/data/dto/upload_avatar_dto.dart';
import 'package:medi_express_patients/features/account/data/dto/weight_detail_dto.dart';

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
      final response = await accountApiService.updateWeight(
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

  Future<ApiResponse<List<HeightDetailDto>>> getListHeight(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    Log.info("getListHeight in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await accountApiService.getListHeight(
        start,
        end,
        offset,
        limit,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => (data as List)
            .map((item) => HeightDetailDto.fromJson(item))
            .toList(),
      );
    }, 'AccountRemoteDatasource/getListHeight');
  }

  Future<ApiResponse<List<AcidUricDetailDto>>> getListAcidUric(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    Log.info("getListAcidUric in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await accountApiService.getListAcidUric(
        start,
        end,
        offset,
        limit,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => (data as List)
            .map((item) => AcidUricDetailDto.fromJson(item))
            .toList(),
      );
    }, 'AccountRemoteDatasource/getListAcidUric');
  }

  Future<ApiResponse<List<Spo2DetailDto>>> getListSpo2(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    Log.info("getListSpo2 in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await accountApiService.getListSpo2(
        start,
        end,
        offset,
        limit,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) =>
            (data as List).map((item) => Spo2DetailDto.fromJson(item)).toList(),
      );
    }, 'AccountRemoteDatasource/getListSpo2');
  }

  Future<ApiResponse<List<BloodPressureDetailDto>>> getListBloodPressure(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    Log.info("getListBloodPressure in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await accountApiService.getListBloodPressure(
        start,
        end,
        offset,
        limit,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => (data as List)
            .map((item) => BloodPressureDetailDto.fromJson(item))
            .toList(),
      );
    }, 'AccountRemoteDatasource/getListBloodPressure');
  }

  Future<ApiResponse<List<BloodSugarDetailDto>>> getListBloodSugar(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    Log.info("getListBloodSugar in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await accountApiService.getListBloodSugar(
        start,
        end,
        offset,
        limit,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => (data as List)
            .map((item) => BloodSugarDetailDto.fromJson(item))
            .toList(),
      );
    }, 'AccountRemoteDatasource/getListBloodSugar');
  }

  Future<ApiResponse<List<HeartRateDetailDto>>> getListHeartRate(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    Log.info("getListHeartRate in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await accountApiService.getListHeartRate(
        start,
        end,
        offset,
        limit,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => (data as List)
            .map((item) => HeartRateDetailDto.fromJson(item))
            .toList(),
      );
    }, 'AccountRemoteDatasource/getListHeartRate');
  }

  Future<ApiResponse<List<TemperatureDetailDto>>> getListTemperature(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    Log.info("getListTemperature in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await accountApiService.getListTemperature(
        start,
        end,
        offset,
        limit,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => (data as List)
            .map((item) => TemperatureDetailDto.fromJson(item))
            .toList(),
      );
    }, 'AccountRemoteDatasource/getListTemperature');
  }

  Future<ApiResponse<List<WeightDetailDto>>> getListWeight(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    Log.info("getListWeight in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await accountApiService.getListWeight(
        start,
        end,
        offset,
        limit,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => (data as List)
            .map((item) => WeightDetailDto.fromJson(item))
            .toList(),
      );
    }, 'AccountRemoteDatasource/getListWeight');
  }
}
