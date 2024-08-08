import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/network/api_response.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:medi_express_patients/features/auth/data/dto/city_dto.dart';
import 'package:medi_express_patients/features/auth/data/dto/create_medical_history_dto.dart';
import 'package:medi_express_patients/features/auth/data/dto/district_dto.dart';
import 'package:medi_express_patients/features/auth/data/dto/forgot_password_dto.dart';
import 'package:medi_express_patients/features/auth/data/dto/register_dto.dart';
import 'package:medi_express_patients/features/auth/data/dto/user_dto.dart';
import 'package:medi_express_patients/features/auth/data/dto/ward_dto.dart';
import 'package:medi_express_patients/features/auth/domain/entities/user_entity.dart';
import 'package:medi_express_patients/features/doctor/data/datasources/remote/doctor_api_service.dart';
import 'package:medi_express_patients/features/doctor/data/dto/doctor_dto.dart';
import 'package:medi_express_patients/features/doctor/data/dto/doctor_by_name_dto.dart';
import 'package:medi_express_patients/features/doctor/data/dto/doctor_information_detail_dto.dart';
import 'package:medi_express_patients/features/doctor/data/dto/information_doctor_dto.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/doctor_information_detail_entity.dart';
import 'package:medi_express_patients/features/schedule/data/datasources/remote/schedule_api_service.dart';
import 'package:medi_express_patients/features/schedule/data/dto/schedule_dto.dart';
import 'package:medi_express_patients/features/schedule/data/dto/schedule_result_dto.dart';

class ScheduleRemoteDatasource {
  final ScheduleApiService apiService;

  ScheduleRemoteDatasource(this.apiService);

  Future<ApiResponse<List<ScheduleDto>>> getAllSchedule(String status) async {
    Log.info("getAllSchedule in DoctorRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getAllSchedule(status);
      return ApiResponse.fromJson(
        response.data!,
        (data) =>
            (data as List).map((item) => ScheduleDto.fromJson(item)).toList(),
      );
    }, 'DoctorRemoteDatasource/getAllSchedule');
  }

  Future<ApiResponse<ScheduleResultDto>> getScheduleResult(String id) async {
    Log.info("getScheduleResult in DoctorRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getScheduleResult(id);
      return ApiResponse.fromJson(
        response.data!,
        (data) => ScheduleResultDto.fromJson(data),
      );
    }, 'DoctorRemoteDatasource/getScheduleResult');
  }
}
