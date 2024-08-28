import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/network/api_response.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/doctor/data/datasources/remote/doctor_api_service.dart';
import 'package:medi_express_patients/features/doctor/data/dto/doctor_by_name_dto.dart';
import 'package:medi_express_patients/features/doctor/data/dto/doctor_dto.dart';
import 'package:medi_express_patients/features/doctor/data/dto/doctor_information_detail_dto.dart';
import 'package:medi_express_patients/features/doctor/data/dto/information_doctor_dto.dart';
import 'package:medi_express_patients/features/doctor/domain/params/create_apointment_id_params.dart';
import 'package:medi_express_patients/features/schedule/data/dto/create_appointment_dto.dart';
import 'package:medi_express_patients/features/schedule/data/dto/service_type_dto.dart';
import 'package:medi_express_patients/features/schedule/data/dto/type_create_appointment_service_dto.dart';

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

  Future<ApiResponse<List<DoctorByNameDto>>> getDoctorByName(
      String nameDoctor) async {
    Log.info("getDoctorByName in DoctorRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getDoctorByName(nameDoctor);
      return ApiResponse.fromJson(
        response.data!,
        (data) => (data as List)
            .map((item) => DoctorByNameDto.fromJson(item))
            .toList(),
      );
    }, 'DoctorRemoteDatasource/getDoctorByName');
  }

  Future<ApiResponse<List<InformationDoctorDto>>>
      getAllInformationDoctor() async {
    Log.info("getAllInformationDoctor in DoctorRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getAllInformationDoctor();
      return ApiResponse.fromJson(
        response.data!,
        (data) => (data as List)
            .map((item) => InformationDoctorDto.fromJson(item))
            .toList(),
      );
    }, 'DoctorRemoteDatasource/getAllInformationDoctor');
  }

  Future<ApiResponse<DoctorInformationDetailDto>> getDoctorInformationDetail(
      int doctorId) async {
    Log.info("getDoctorInformationDetail in DoctorRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getDoctorInformationDetail(doctorId);
      return ApiResponse.fromJson(
        response.data!,
        (data) => DoctorInformationDetailDto.fromJson(data),
      );
    }, 'DoctorRemoteDatasource/getDoctorInformationDetail');
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
      CreateAppointmentIdParams params) async {
    Log.info("createAppointment in ScheduleRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.createAppointment(params);
      return ApiResponse.fromJson(
        response.data!,
        (data) => CreateAppointmentDto.fromJson(data),
      );
    }, 'ScheduleRemoteDatasource/createAppointment');
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
