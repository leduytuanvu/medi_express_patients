import 'package:dio/dio.dart';

class AccountApiService {
  final Dio dio;

  AccountApiService(this.dio);

  Future<Response<Map<String, dynamic>>> login(
    String phoneNumber,
    String password,
  ) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/mediexpress/signIn',
      data: {
        'phoneNumber': phoneNumber,
        'password': password,
      },
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getHealthMetrics(
      String patientId) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/medical/healthmetrics',
      queryParameters: {'PatientID': patientId},
    );
    return response;
  }
}
