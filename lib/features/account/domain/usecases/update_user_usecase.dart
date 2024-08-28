import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/account/domain/entities/update_user_entity.dart';
import 'package:medi_express_patients/features/account/domain/params/update_user_params.dart';
import 'package:medi_express_patients/features/account/domain/repositories/account_repository.dart';

class UpdateUserUsecase implements UseCase<UpdateUserEntity, UpdateUserParams> {
  final AccountRepository repository;

  UpdateUserUsecase(this.repository);

  @override
  Future<Either<Failure, UpdateUserEntity>> call(
      UpdateUserParams params) async {
    try {
      Log.info("UpdateUserUsecase");
      final result = await repository.updateUser(
        params.gender,
        params.address,
        params.email,
        params.wardId,
        params.name,
        params.birthdate,
        params.bhytCode,
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
