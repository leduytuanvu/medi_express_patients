import 'package:dio/dio.dart';
import 'package:medi_express_patients/features/schedule/domain/params/create_appointment_params.dart';

class ScheduleApiService {
  final Dio dio;

  ScheduleApiService(this.dio);

  Future<Response<Map<String, dynamic>>> getAllSchedule(String status) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/medical/appointment',
      queryParameters: {'Status': status},
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getScheduleResult(String id) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/medical/appointment/getAppointmentResults',
      queryParameters: {'id': id},
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>>
      getTypeCreateAppointmentService() async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/medical/services',
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getServiceType() async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/medical/servicestype',
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> createAppointment(
      CreateAppointmentParams params) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/mediexpress/medical/appointment/createAppointmentPatient',
      data: {
        'PatientID': params.patientID,
        'ServiceID': params.serviceID,
        'ServiceTypeID': params.serviceTypeID,
        'AppointmentDate': params.appointmentDate,
        'StartTime': params.startTime,
        'EndTime': params.endTime,
      },
    );
    return response;
  }
}
