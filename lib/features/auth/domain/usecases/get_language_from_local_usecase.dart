import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/auth/domain/repositories/auth_repository.dart';

class GetLanguageFromLocalUsecase implements UseCase<String, NoParams> {
  final AuthRepository repository;

  GetLanguageFromLocalUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    try {
      Log.info("GetLanguageFromLocalUsecase");
      final result = await repository.getLanguageFromLocal();
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
