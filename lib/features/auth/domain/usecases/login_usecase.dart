import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/extensions/exception_extension.dart';
import '../entities/auth_entity.dart';
import '../params/login_params.dart';
import '../repositories/auth_repository.dart';

class LoginUsecase implements UseCase<AuthEntity, LoginParams> {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(LoginParams params) async {
    try {
      Log.info("LoginUsecase");
      final auth = await repository.login(
        params.phoneNumber,
        params.password,
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
