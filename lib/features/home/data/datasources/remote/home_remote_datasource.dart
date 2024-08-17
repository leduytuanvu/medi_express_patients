import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/network/api_response.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/home/data/datasources/remote/home_api_service.dart';
import 'package:medi_express_patients/features/home/data/dto/create_health_record_dto.dart';
import 'package:medi_express_patients/features/home/data/dto/health_record_dto.dart';

import '../../dto/home_examination_package_dto.dart';

class HomeRemoteDatasource {
  final HomeApiService apiService;

  HomeRemoteDatasource(this.apiService);

  Future<ApiResponse<List<HealthRecordDto>>> getAllHealthRecord() async {
    Log.info("getAllHealthRecord in HomeRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getAllHealthRecord();
      return ApiResponse.fromJson(
        response.data!,
        (data) => (data as List)
            .map((item) => HealthRecordDto.fromJson(item))
            .toList(),
      );
    }, 'HomeRemoteDatasource/getAllHealthRecord');
  }

  Future<ApiResponse<List<HomeExaminationPackageDto>>>
      getListHomeExaminationPackage() async {
    Log.info("getListHomeExaminationPackage in HomeRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getListHomeExaminationPackage();
      return ApiResponse.fromJson(
        response.data!,
        (data) => (data as List)
            .map((item) => HomeExaminationPackageDto.fromJson(item))
            .toList(),
      );
    }, 'HomeRemoteDatasource/getListHomeExaminationPackage');
  }

  Future<ApiResponse<CreateHealthRecordDto>> createHealthRecord() async {
    Log.info("createHealthRecord in HomeRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getListHomeExaminationPackage();
      return ApiResponse.fromJson(
        response.data!,
        (data) => CreateHealthRecordDto.fromJson(data),
      );
    }, 'HomeRemoteDatasource/createHealthRecord');
  }
}
