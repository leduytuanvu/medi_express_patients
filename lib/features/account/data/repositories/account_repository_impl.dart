import 'dart:io';

import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/exceptions.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/account/data/datasource/local/account_local_datasource.dart';
import 'package:medi_express_patients/features/account/data/datasource/remote/account_remote_datasource.dart';
import 'package:medi_express_patients/features/account/domain/entities/health_metricts_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/upload_avatar_entity.dart';
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
}
