import 'dart:convert';

import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/exceptions.dart';
import 'package:medi_express_patients/core/utils/common/constants.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/auth/domain/entities/city_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/create_medical_history_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/district_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/forgot_password_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/register_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/user_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/ward_entity.dart';
import 'package:medi_express_patients/features/doctor/data/datasources/local/doctor_local_datasource.dart';
import 'package:medi_express_patients/features/doctor/data/datasources/remote/doctor_remote_datasource.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/doctor_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/doctor_information_detail_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/information_doctor_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:medi_express_patients/features/schedule/data/datasources/local/schedule_local_datasource.dart';
import 'package:medi_express_patients/features/schedule/data/datasources/remote/schedule_remote_datasource.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/schedule_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/schedule_result_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleLocalDatasource localDatasource;
  final ScheduleRemoteDatasource remoteDatasource;

  ScheduleRepositoryImpl(this.localDatasource, this.remoteDatasource);

  @override
  Future<List<ScheduleEntity>> getAllSchedule(String status) async {
    Log.info("getAllDoctor in ScheduleRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getAllSchedule(status);
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList() ?? [];
      } else if (apiResponse.code == 0) {
        return [];
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in ScheduleRepositoryImpl/getAllSchedule',
        );
      }
    }, 'ScheduleRepositoryImpl/getAllSchedule');
  }

  @override
  Future<ScheduleResultEntity> getScheduleResult(String id) async {
    Log.info("getScheduleResult in ScheduleRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getScheduleResult(id);
      Log.info(
          "apiResponse: ${apiResponse.message}, ${apiResponse.code}, ${apiResponse.data}");
      if (apiResponse.data == null) {
        return ScheduleResultEntity();
      } else {
        if (apiResponse.code == 1) {
          return apiResponse.data!.toEntity();
        } else {
          throw ApiErrorException(
            apiResponse.message,
            '${apiResponse.message} in ScheduleRepositoryImpl/getScheduleResult',
          );
        }
      }
    }, 'ScheduleRepositoryImpl/getScheduleResult');
  }
}
