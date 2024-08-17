import 'package:dio/dio.dart';

class AuthApiService {
  final Dio dio;

  AuthApiService(this.dio);

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

  Future<Response<Map<String, dynamic>>> register(
    String phoneNumber,
    String name,
    String address,
    String email,
    int wardId,
    int gender,
    String birthdate,
    String password,
    String role,
  ) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/mediexpress/signUp',
      data: {
        'PhoneNumber': phoneNumber,
        'Name': name,
        'Addressed': address,
        'Email': email,
        'WardID': wardId,
        'Gender': gender,
        'BirthDate': birthdate,
        'Password': password,
        'Role': role,
      },
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> forgotPassword(
    String phoneNumber,
    String password,
  ) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/mediexpress/forgotPassword',
      data: {
        'phoneNumber': phoneNumber,
        'password': password,
      },
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/mediexpress/changePassword',
      data: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      },
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getAllCity() async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/address/getAllCity',
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getDistrictByCity(
    int cityId,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/address/getDistrictByCity',
      queryParameters: {'CityID': cityId},
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> checkPhoneNumberExists(
    String phoneNumber,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/checkPhoneNumber',
      queryParameters: {'PhoneNumber': phoneNumber},
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getWardByDistrict(
    int districtId,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/address/getWardByDistrict',
      queryParameters: {'DistrictID': districtId},
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getUserInformation() async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/user/getPersonal',
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> createMedicalHistory(
    int patientId,
    bool hypertension,
    bool diabetes,
    bool heartDisease,
    bool stroke,
    bool asthma,
    bool epilepsy,
    bool copd,
    bool palpitations,
    String otherMedicalHistory,
  ) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/mediexpress/medical/history',
      data: {
        'PatientID': patientId,
        'Hypertension': hypertension,
        'Diabetes': diabetes,
        'HeartDisease': heartDisease,
        'Stroke': stroke,
        'Asthma': asthma,
        'Epilepsy': epilepsy,
        'COPD': copd,
        'Palpitations': palpitations,
        'OtherMedicalHistory': otherMedicalHistory,
      },
    );
    return response;
  }
}
