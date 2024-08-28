import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/exceptions.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/doctor/data/datasources/local/doctor_local_datasource.dart';
import 'package:medi_express_patients/features/doctor/data/datasources/remote/doctor_remote_datasource.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/doctor_by_name_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/doctor_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/doctor_information_detail_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/information_doctor_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/params/create_apointment_id_params.dart';
import 'package:medi_express_patients/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/create_appointment_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/service_type_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/type_create_appointment_service_entity.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorLocalDatasource localDatasource;
  final DoctorRemoteDatasource remoteDatasource;

  DoctorRepositoryImpl(this.localDatasource, this.remoteDatasource);

  @override
  Future<List<DoctorEntity>> getAllDoctor() async {
    Log.info("getAllDoctor in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getAllDoctor();
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in DoctorRepositoryImpl/getAllDoctor',
        );
      }
    }, 'DoctorRepositoryImpl/getAllDoctor');
  }

  @override
  Future<List<InformationDoctorEntity>> getAllInformationDoctor() async {
    Log.info("getAllInformationDoctor in DoctorRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getAllInformationDoctor();
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in DoctorRepositoryImpl/getAllInformationDoctor',
        );
      }
    }, 'DoctorRepositoryImpl/getAllInformationDoctor');
  }

  @override
  Future<List<DoctorByNameEntity>> getDoctorByName(String name) async {
    Log.info("getDoctorByName in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getDoctorByName(name);
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in DoctorRepositoryImpl/getDoctorByName',
        );
      }
    }, 'DoctorRepositoryImpl/getDoctorByName');
  }

  @override
  Future<DoctorInformationDetailEntity> getDoctorInformationDetail(
      int doctorId) async {
    Log.info("getDoctorInformationDetail in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse =
          await remoteDatasource.getDoctorInformationDetail(doctorId);
      if (apiResponse.code == 1) {
        return apiResponse.data!.toEntity();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in DoctorRepositoryImpl/getDoctorInformationDetail',
        );
      }
    }, 'DoctorRepositoryImpl/getDoctorInformationDetail');
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
  Future<CreateAppointmentEntity> createAppointment(
      CreateAppointmentIdParams params) async {
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
