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
}
