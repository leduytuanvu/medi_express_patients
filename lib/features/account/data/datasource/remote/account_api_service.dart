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

  Future<Response<Map<String, dynamic>>> updateUser(
    String gender,
    String phoneNumber,
    String address,
    String email,
    int wardId,
    String name,
    String birthdate,
    String bhytCode,
  ) async {
    final response = await dio.put<Map<String, dynamic>>(
      '/mediexpress/user',
      data: {
        'Gender': gender,
        'PhoneNumber': phoneNumber,
        'Addressed': address,
        'Email': email,
        'WardID': wardId,
        'Name': name,
        'BirthDate': birthdate,
        'BHYTCode': bhytCode,
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
