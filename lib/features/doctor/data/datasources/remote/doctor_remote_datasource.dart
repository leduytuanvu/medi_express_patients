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
import 'package:medi_express_patients/features/doctor/data/dto/information_doctor_dto.dart';

class DoctorRemoteDatasource {
  final DoctorApiService apiService;

  DoctorRemoteDatasource(this.apiService);

  Future<ApiResponse<List<DoctorDto>>> getAllDoctor() async {
    Log.info("getAllDoctor in DoctorRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getAllDoctor();
      return ApiResponse.fromJson(
        response.data!,
            (data) =>
            (data as List).map((item) => DoctorDto.fromJson(item)).toList(),
      );
    }, 'DoctorRemoteDatasource/getAllDoctor');
  }

  Future<ApiResponse<List<DoctorByNameDto>>> getDoctorByName(String nameDoctor) async {
    Log.info("getDoctorByName in DoctorRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getDoctorByName(nameDoctor);
      return ApiResponse.fromJson(
        response.data!,
            (data) =>
            (data as List).map((item) => DoctorByNameDto.fromJson(item)).toList(),
      );
    }, 'DoctorRemoteDatasource/getDoctorByName');
  }

  Future<ApiResponse<List<InformationDoctorDto>>> getAllInformationDoctor() async {
    Log.info("getAllInformationDoctor in DoctorRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getAllInformationDoctor();
      return ApiResponse.fromJson(
        response.data!,
            (data) =>
            (data as List).map((item) => InformationDoctorDto.fromJson(item)).toList(),
      );
    }, 'DoctorRemoteDatasource/getAllInformationDoctor');
  }

  // Future<ApiResponse<List<DoctorDto>>> getDoctorDetail() async {
  //   Log.info("getDoctorDetail in DoctorRemoteDatasource");
  //   return executeWithHandling(() async {
  //     final response = await apiService.getDoctorDetail();
  //     return ApiResponse.fromJson(
  //       response.data!,
  //           (data) =>
  //           (data as List).map((item) => DoctorDto.fromJson(item)).toList(),
  //     );
  //   }, 'DoctorRemoteDatasource/getDoctorDetail');
  // }
}
