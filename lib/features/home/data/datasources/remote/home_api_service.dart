import 'dart:io';

import 'package:dio/dio.dart';

class HomeApiService {
  final Dio dio;

  HomeApiService(this.dio);

  Future<Response<Map<String, dynamic>>> getAllHealthRecord() async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/medical/healthrecord/getHealRecordByPatient',
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getListHomeExaminationPackage() async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/medical/services',
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> createHealthRecord(
    File file,
    String nameHealthRecord,
    String description,
  ) async {
    String url = '/mediexpress/medical/healthrecord/';
    FormData formData = FormData.fromMap({
      'FilePath': await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last),
      'NameHealthRecord': nameHealthRecord,
      'Description': description,
    });
    final response = await dio.post<Map<String, dynamic>>(url, data: formData);
    return response;
  }
}
