import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/auth/domain/entities/register_entity.dart';
import 'package:medi_express_patients/features/auth/domain/params/register_params.dart';
import 'package:medi_express_patients/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase implements UseCase<RegisterEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  @override
  Future<Either<Failure, RegisterEntity>> call(RegisterParams params) async {
    try {
      Log.info("RegisterUsecase");
      final auth = await repository.register(
        params.phoneNumber,
        params.name,
        params.address,
        params.email,
        params.wardId,
        params.gender,
        params.birthdate,
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
