import 'package:dio/dio.dart';

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

  Future<Response<Map<String, dynamic>>> getDoctorInformationDetail(int doctorId) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/doctor/information/getDoctorDetail',
      queryParameters: {'DoctorID': doctorId},
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
