import 'dart:io';

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

  Future<Response<Map<String, dynamic>>> updateHeight(
    int patientId,
    double height,
    String createAt,
  ) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/mediexpress/medical/healthmetrics/height',
      data: {
        'PatientID': patientId,
        'Height': height.toString(),
        'createdAt': createAt,
      },
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> updateWeight(
    int patientId,
    double weight,
    String createAt,
  ) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/mediexpress/medical/healthmetrics/weight',
      data: {
        'PatientID': patientId,
        'Weight': weight.toString(),
        'createdAt': createAt,
      },
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> uploadAvatar(File file) async {
    FormData formData = FormData.fromMap({
      'Avatar': await MultipartFile.fromFile(file.path, filename: 'avatar.png'),
    });
    final response = await dio.put<Map<String, dynamic>>(
      '/mediexpress/user/uploadAvatars',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> updateUser(
    int gender,
    String address,
    String email,
    int wardId,
    String name,
    String birthdate,
    String bhytCode,
  ) async {
    final response = await dio.put<Map<String, dynamic>>(
      'mediexpress/user/editPersonal',
      data: {
        'Gender': gender,
        'Addressed': address,
        'Email': email,
        'WardID': wardId,
        'Name': name,
        'BHYTCode': bhytCode,
        'BirthDate': birthdate,
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

  Future<Response<Map<String, dynamic>>> getListHeight(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/medical/healthmetrics/getHeight',
      queryParameters: {
        'start': start,
        'end': end,
        'offset': offset,
        'limit': limit,
      },
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getListAcidUric(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/medical/healthmetrics/getAciduric',
      queryParameters: {
        'start': start,
        'end': end,
        'offset': offset,
        'limit': limit,
      },
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getListSpo2(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/medical/healthmetrics/getSpO2',
      queryParameters: {
        'start': start,
        'end': end,
        'offset': offset,
        'limit': limit,
      },
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getListBloodPressure(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/medical/healthmetrics/getBloodPressure',
      queryParameters: {
        'start': start,
        'end': end,
        'offset': offset,
        'limit': limit,
      },
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getListBloodSugar(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/medical/healthmetrics/getBloodSugar',
      queryParameters: {
        'start': start,
        'end': end,
        'offset': offset,
        'limit': limit,
      },
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getListHeartRate(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/medical/healthmetrics/getHeartRate',
      queryParameters: {
        'start': start,
        'end': end,
        'offset': offset,
        'limit': limit,
      },
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getListTemperature(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/medical/healthmetrics/getTemperature',
      queryParameters: {
        'start': start,
        'end': end,
        'offset': offset,
        'limit': limit,
      },
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getListWeight(
    String start,
    String end,
    String offset,
    String limit,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/medical/healthmetrics/getWeight',
      queryParameters: {
        'start': start,
        'end': end,
        'offset': offset,
        'limit': limit,
      },
    );
    return response;
  }
}
