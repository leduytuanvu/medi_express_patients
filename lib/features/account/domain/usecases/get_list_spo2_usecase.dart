import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/account/domain/entities/spo2_detail_entity.dart';
import 'package:medi_express_patients/features/account/domain/params/get_list_health_index_params.dart';
import 'package:medi_express_patients/features/account/domain/repositories/account_repository.dart';

class GetListSpo2Usecase
    implements UseCase<List<Spo2DetailEntity>, GetListHealthIndexParams> {
  final AccountRepository repository;

  GetListSpo2Usecase(this.repository);

  @override
  Future<Either<Failure, List<Spo2DetailEntity>>> call(
      GetListHealthIndexParams params) async {
    try {
      Log.info("GetHealthMetrictsUsecase");
      final result = await repository.getListSpo2(
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
