import 'package:dio/dio.dart';
import 'package:medi_express_patients/features/doctor/domain/params/create_apointment_id_params.dart';

class DoctorApiService {
  final Dio dio;

  DoctorApiService(this.dio);

  Future<Response<Map<String, dynamic>>> getAllDoctor() async {
    final response = await dio.post<Map<String, dynamic>>(
      '/mediexpress/user/getAllDoctorbyPatient',
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getDoctorByName(
    String nameDoctor,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/user/searchDoctor',
      queryParameters: {'Name': nameDoctor},
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getAllInformationDoctor() async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/doctor/information',
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getDoctorInformationDetail(
      int doctorId) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/doctor/information/getDoctorDetail',
      queryParameters: {'DoctorID': doctorId},
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
      CreateAppointmentIdParams params) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/mediexpress/medical/appointment/',
      data: {
        "DoctorID": params.doctorId,
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

  // Future<Response<Map<String, dynamic>>> getDoctorDetail(
  //     String doctorId,
  //     ) async {
  //   final response = await dio.get<Map<String, dynamic>>(
  //     '/mediexpress/doctor/information/getDoctorDetail',
  //     queryParameters: {'DoctorID': doctorId},
  //   );
  //   return response;
  // }
}
