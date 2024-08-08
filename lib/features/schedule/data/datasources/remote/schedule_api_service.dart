import 'package:dio/dio.dart';

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
}
