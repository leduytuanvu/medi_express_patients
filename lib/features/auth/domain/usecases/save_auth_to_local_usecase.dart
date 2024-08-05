import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/features/auth/domain/entities/auth_entity.dart';
import 'package:medi_express_patients/features/auth/domain/params/save_auth_to_local_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/extensions/exception_extension.dart';
import '../repositories/auth_repository.dart';

class SaveAuthToLocalUsecase implements UseCase<bool, SaveAuthToLocalParams> {
  final AuthRepository repository;

  SaveAuthToLocalUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(SaveAuthToLocalParams params) async {
    try {
      Log.info("SaveAuthToLocalUsecase");
      final result = await repository.saveAuthToLocal(params.auth);
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
