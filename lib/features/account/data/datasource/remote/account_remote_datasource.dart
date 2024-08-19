import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/network/api_response.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/account/data/datasource/remote/account_api_service.dart';
import 'package:medi_express_patients/features/account/data/dto/health_metricts_dto.dart';

class AccountRemoteDatasource {
  final AccountApiService accountApiService;

  AccountRemoteDatasource(this.accountApiService);

  Future<ApiResponse<HealthMetricsDto>> getHealthMetrics(
    String patientId,
  ) async {
    Log.info("getHealthMetrics in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await accountApiService.getHealthMetrics(patientId);
      return ApiResponse.fromJson(
        response.data!,
        (data) => HealthMetricsDto.fromJson(data),
      );
    }, 'AccountRemoteDatasource/getHealthMetrics');
  }
}
