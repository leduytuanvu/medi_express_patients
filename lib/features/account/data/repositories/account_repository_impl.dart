import 'dart:io';

import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/exceptions.dart';
import 'package:medi_express_patients/core/network/api_response.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/account/data/datasource/local/account_local_datasource.dart';
import 'package:medi_express_patients/features/account/data/datasource/remote/account_remote_datasource.dart';
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
import 'package:medi_express_patients/features/account/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountLocalDatasource localDatasource;
  final AccountRemoteDatasource remoteDatasource;

  AccountRepositoryImpl(this.localDatasource, this.remoteDatasource);

  @override
  Future<HealthMetricsEntity> getHealthMetrics(
    String patientId,
  ) async {
    Log.info("getHealthMetrics in AccountRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getHealthMetrics(
        patientId,
      );
      if (apiResponse.code == 1) {
        return apiResponse.data!.toEntity();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AccountRepositoryImpl/getHealthMetrics',
        );
      }
    }, 'AccountRepositoryImpl/getHealthMetrics');
  }

  @override
  Future<List<HeightDetailEntity>> getListHeight(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    Log.info("getListHeight in AccountRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getListHeight(
        start,
        end,
        offset,
        limit,
      );
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AccountRepositoryImpl/getListHeight',
        );
      }
    }, 'AccountRepositoryImpl/getListHeight');
  }

  @override
  Future<List<AcidUricDetailEntity>> getListAcidUric(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    Log.info("getListHeight in AccountRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getListAcidUric(
        start,
        end,
        offset,
        limit,
      );
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AccountRepositoryImpl/getListHeight',
        );
      }
    }, 'AccountRepositoryImpl/getListHeight');
  }

  @override
  Future<List<Spo2DetailEntity>> getListSpo2(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    Log.info("getListHeight in AccountRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getListSpo2(
        start,
        end,
        offset,
        limit,
      );
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AccountRepositoryImpl/getListHeight',
        );
      }
    }, 'AccountRepositoryImpl/getListHeight');
  }

  @override
  Future<List<BloodPressureDetailEntity>> getListBloodPressure(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    Log.info("getListHeight in AccountRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getListBloodPressure(
        start,
        end,
        offset,
        limit,
      );
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AccountRepositoryImpl/getListHeight',
        );
      }
    }, 'AccountRepositoryImpl/getListHeight');
  }

  @override
  Future<List<BloodSugarDetailEntity>> getListBloodSugar(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    Log.info("getListHeight in AccountRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getListBloodSugar(
        start,
        end,
        offset,
        limit,
      );
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AccountRepositoryImpl/getListHeight',
        );
      }
    }, 'AccountRepositoryImpl/getListHeight');
  }

  @override
  Future<List<HeartRateDetailEntity>> getListHeartRate(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    Log.info("getListHeight in AccountRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getListHeartRate(
        start,
        end,
        offset,
        limit,
      );
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AccountRepositoryImpl/getListHeight',
        );
      }
    }, 'AccountRepositoryImpl/getListHeight');
  }

  @override
  Future<List<TemperatureDetailEntity>> getListTemperature(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    Log.info("getListHeight in AccountRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getListTemperature(
        start,
        end,
        offset,
        limit,
      );
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AccountRepositoryImpl/getListHeight',
        );
      }
    }, 'AccountRepositoryImpl/getListHeight');
  }

  @override
  Future<List<WeightDetailEntity>> getListWeight(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    Log.info("getListHeight in AccountRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getListWeight(
        start,
        end,
        offset,
        limit,
      );
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AccountRepositoryImpl/getListHeight',
        );
      }
    }, 'AccountRepositoryImpl/getListHeight');
  }

  @override
  Future<ApiResponse<dynamic>> updateHeight(
    int patientId,
    double height,
    String createAt,
  ) async {
    Log.info("updateHeight in AccountRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse =
          await remoteDatasource.updateHeight(patientId, height, createAt);
      return apiResponse;
    }, 'AccountRepositoryImpl/updateHeight');
  }

  @override
  Future<ApiResponse<dynamic>> updateWeight(
    int patientId,
    double weight,
    String createAt,
  ) async {
    Log.info("updateWeight in AccountRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse =
          await remoteDatasource.updateWeight(patientId, weight, createAt);
      return apiResponse;
    }, 'AccountRepositoryImpl/updateWeight');
  }

  @override
  Future<UploadAvatarEntity> uploadAvatar(File file) async {
    Log.info("uploadAvatar in AccountRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.uploadAvatar(file);
      if (apiResponse.code == 1) {
        return apiResponse.data!.toEntity();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AccountRepositoryImpl/uploadAvatar',
        );
      }
    }, 'AccountRepositoryImpl/uploadAvatar');
  }

  @override
  Future<UpdateUserEntity> updateUser(
    int gender,
    String address,
    String email,
    int wardId,
    String name,
    String birthdate,
    String bhytCode,
  ) async {
    Log.info("updateUser in AccountRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.updateUser(
        gender,
        address,
        email,
        wardId,
        name,
        birthdate,
        bhytCode,
      );
      if (apiResponse.code == 1) {
        return apiResponse.data!.toEntity();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AccountRepositoryImpl/updateUser',
        );
      }
    }, 'AccountRepositoryImpl/updateUser');
  }
}
