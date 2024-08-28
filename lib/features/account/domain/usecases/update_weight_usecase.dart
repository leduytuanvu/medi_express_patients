import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/network/api_response.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/account/domain/params/update_height_params.dart';
import 'package:medi_express_patients/features/account/domain/repositories/account_repository.dart';

class UpdateWeightUsecase
    implements UseCase<ApiResponse<dynamic>, UpdateHeightParams> {
  final AccountRepository repository;

  UpdateWeightUsecase(this.repository);

  @override
  Future<Either<Failure, ApiResponse<dynamic>>> call(
      UpdateHeightParams params) async {
    try {
      Log.info("UpdateWeightUsecase");
      final result = await repository.updateHeight(
        params.patientId,
        params.height,
        params.createAt,
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
