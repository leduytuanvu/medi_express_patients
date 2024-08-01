import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/auth/domain/params/change_password_params.dart';
import 'package:medi_express_patients/features/auth/domain/repositories/auth_repository.dart';

class ChangePasswordUsecase implements UseCase<int, ChangePasswordParams> {
  final AuthRepository repository;

  ChangePasswordUsecase(this.repository);

  @override
  Future<Either<Failure, int>> call(ChangePasswordParams params) async {
    try {
      Log.info("ChangePasswordUsecase");
      final auth = await repository.changePassword(
        params.oldPassword,
        params.newPassword,
      );
      Log.info('auth: $auth');
      return Right(auth);
    } catch (error) {
      Log.info('error auth: $error');
      if (error is Exception) {
        return Left(error.toFailure());
      } else {
        return Left(UnknownFailure('Unknown error', error.toString()));
      }
    }
  }
}
