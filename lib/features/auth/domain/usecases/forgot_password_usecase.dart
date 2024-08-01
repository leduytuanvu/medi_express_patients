import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/auth/domain/entities/forgot_password_entity.dart';
import 'package:medi_express_patients/features/auth/domain/params/forgot_password_params.dart';
import 'package:medi_express_patients/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUsecase
    implements UseCase<ForgotPasswordEntity, ForgotPasswordParams> {
  final AuthRepository repository;

  ForgotPasswordUsecase(this.repository);

  @override
  Future<Either<Failure, ForgotPasswordEntity>> call(
      ForgotPasswordParams params) async {
    try {
      Log.info("LoginUsecase");
      final result = await repository.forgotPassword(
        params.phoneNumber,
        params.password,
      );
      Log.info('result: $result');
      return Right(result);
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
