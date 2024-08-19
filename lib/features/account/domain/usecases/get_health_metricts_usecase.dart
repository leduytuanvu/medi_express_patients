import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/account/domain/entities/health_metricts_entity.dart';
import 'package:medi_express_patients/features/account/domain/repositories/account_repository.dart';

class GetHealthMetrictsUsecase implements UseCase<HealthMetricsEntity, String> {
  final AccountRepository repository;

  GetHealthMetrictsUsecase(this.repository);

  @override
  Future<Either<Failure, HealthMetricsEntity>> call(String params) async {
    try {
      Log.info("GetHealthMetrictsUsecase");
      final result = await repository.getHealthMetrics(
        params,
      );
      Log.info('result: $result');
      return Right(result);
    } catch (error) {
      Log.info('error result: $error');
      if (error is Exception) {
        return Left(error.toFailure());
      } else {
        return Left(UnknownFailure('Unknown error', error.toString()));
      }
    }
  }
}
