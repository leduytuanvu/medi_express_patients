import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/features/auth/domain/entities/auth_entity.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/extensions/exception_extension.dart';
import '../repositories/auth_repository.dart';

class GetAuthFromLocalUsecase implements UseCase<AuthEntity, NoParams> {
  final AuthRepository repository;

  GetAuthFromLocalUsecase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(NoParams params) async {
    try {
      Log.info("GetAuthFromLocalUsecase");
      final result = await repository.getAuthFromLocal();
      Log.info('result: $result');
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
