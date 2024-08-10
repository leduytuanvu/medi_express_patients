import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/exceptions.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/schedule/data/datasources/local/schedule_local_datasource.dart';
import 'package:medi_express_patients/features/schedule/data/datasources/remote/schedule_remote_datasource.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/create_appointment_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/schedule_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/schedule_result_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/service_type_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/type_create_appointment_service_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/params/create_appointment_params.dart';
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
  Future<List<TypeCreateAppointmentServiceEntity>>
      getTypeCreateAppointmentService() async {
    Log.info("getTypeCreateAppointmentService in ScheduleRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse =
          await remoteDatasource.getTypeCreateAppointmentService();
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList() ?? [];
      } else if (apiResponse.code == 0) {
        return [];
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in ScheduleRepositoryImpl/getTypeCreateAppointmentService',
        );
      }
    }, 'ScheduleRepositoryImpl/getTypeCreateAppointmentService');
  }

  @override
  Future<List<ServiceTypeEntity>> getServiceType() async {
    Log.info("getServiceType in ScheduleRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getServiceType();
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList() ?? [];
      } else if (apiResponse.code == 0) {
        return [];
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in ScheduleRepositoryImpl/getServiceType',
        );
      }
    }, 'ScheduleRepositoryImpl/getServiceType');
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

  @override
  Future<CreateAppointmentEntity> createAppointment(
      CreateAppointmentParams params) async {
    Log.info("createAppointment in ScheduleRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.createAppointment(params);
      Log.info(
          "apiResponse: ${apiResponse.message}, ${apiResponse.code}, ${apiResponse.data}");
      if (apiResponse.data == null) {
        return CreateAppointmentEntity();
      } else {
        if (apiResponse.code == 1) {
          return apiResponse.data!.toEntity();
        } else {
          throw ApiErrorException(
            apiResponse.message,
            '${apiResponse.message} in ScheduleRepositoryImpl/createAppointment',
          );
        }
      }
    }, 'ScheduleRepositoryImpl/createAppointment');
  }
}
