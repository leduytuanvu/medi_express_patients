import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/extensions/exception_extension.dart';
import '../repositories/auth_repository.dart';

class SaveLanguageUsecase implements UseCase<bool, String> {
  final AuthRepository repository;

  SaveLanguageUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String params) async {
    try {
      Log.info("SaveLanguageUsecase");
      final result = await repository.saveLanguageToLocal(params);
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
