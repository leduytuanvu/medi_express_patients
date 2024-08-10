import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/network/api_response.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/schedule/data/datasources/remote/schedule_api_service.dart';
import 'package:medi_express_patients/features/schedule/data/dto/create_appointment_dto.dart';
import 'package:medi_express_patients/features/schedule/data/dto/schedule_dto.dart';
import 'package:medi_express_patients/features/schedule/data/dto/schedule_result_dto.dart';
import 'package:medi_express_patients/features/schedule/data/dto/service_type_dto.dart';
import 'package:medi_express_patients/features/schedule/data/dto/type_create_appointment_service_dto.dart';
import 'package:medi_express_patients/features/schedule/domain/params/create_appointment_params.dart';

class ScheduleRemoteDatasource {
  final ScheduleApiService apiService;

  ScheduleRemoteDatasource(this.apiService);

  Future<ApiResponse<List<ScheduleDto>>> getAllSchedule(String status) async {
    Log.info("getAllSchedule in ScheduleRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getAllSchedule(status);
      return ApiResponse.fromJson(
        response.data!,
        (data) =>
            (data as List).map((item) => ScheduleDto.fromJson(item)).toList(),
      );
    }, 'ScheduleRemoteDatasource/getAllSchedule');
  }

  Future<ApiResponse<ScheduleResultDto>> getScheduleResult(String id) async {
    Log.info("getScheduleResult in ScheduleRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getScheduleResult(id);
      return ApiResponse.fromJson(
        response.data!,
        (data) => ScheduleResultDto.fromJson(data),
      );
    }, 'ScheduleRemoteDatasource/getScheduleResult');
  }

  Future<ApiResponse<List<TypeCreateAppointmentServiceDto>>>
      getTypeCreateAppointmentService() async {
    Log.info("getTypeCreateAppointmentService in ScheduleRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getTypeCreateAppointmentService();
      return ApiResponse.fromJson(
        response.data!,
        (data) => (data as List)
            .map((item) => TypeCreateAppointmentServiceDto.fromJson(item))
            .toList(),
      );
    }, 'ScheduleRemoteDatasource/getTypeCreateAppointmentService');
  }

  Future<ApiResponse<List<ServiceTypeDto>>> getServiceType() async {
    Log.info("getServiceType in ScheduleRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getServiceType();
      return ApiResponse.fromJson(
        response.data!,
        (data) => (data as List)
            .map((item) => ServiceTypeDto.fromJson(item))
            .toList(),
      );
    }, 'ScheduleRemoteDatasource/getServiceType');
  }

  Future<ApiResponse<CreateAppointmentDto>> createAppointment(
      CreateAppointmentParams params) async {
    Log.info("createAppointment in ScheduleRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.createAppointment(params);
      return ApiResponse.fromJson(
        response.data!,
        (data) => CreateAppointmentDto.fromJson(data),
      );
    }, 'ScheduleRemoteDatasource/createAppointment');
  }
}
