import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/features/auth/domain/entities/auth_entity.dart';
import 'package:medi_express_patients/features/auth/domain/params/save_auth_to_local_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/extensions/exception_extension.dart';
import '../repositories/auth_repository.dart';

class CheckPhoneNumberExistsUsecase implements UseCase<bool, String> {
  final AuthRepository repository;

  CheckPhoneNumberExistsUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String params) async {
    try {
      Log.info("CheckPhoneNumberExistsUsecase");
      final result = await repository.checkPhoneNumberExists(params);
      return Right(result);
    } catch (error) {
      Log.info('error: $error');
      if (error is Exception) {
        return Left(error.toFailure());
      } else {
        return Left(UnknownFailure('Unknown error', error.toString()));
      }
    }
  }
}
