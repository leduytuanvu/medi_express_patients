import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/account/domain/entities/blood_sugar_detail_entity.dart';
import 'package:medi_express_patients/features/account/domain/params/get_list_health_index_params.dart';
import 'package:medi_express_patients/features/account/domain/repositories/account_repository.dart';

class GetListBloodSugarUsecase
    implements UseCase<List<BloodSugarDetailEntity>, GetListHealthIndexParams> {
  final AccountRepository repository;

  GetListBloodSugarUsecase(this.repository);

  @override
  Future<Either<Failure, List<BloodSugarDetailEntity>>> call(
      GetListHealthIndexParams params) async {
    try {
      Log.info("GetHealthMetrictsUsecase");
      final result = await repository.getListBloodSugar(
        params.start,
        params.end,
        params.offset,
        params.limit,
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
