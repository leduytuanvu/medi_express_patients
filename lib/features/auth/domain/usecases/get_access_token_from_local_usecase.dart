import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/features/auth/domain/entities/auth_entity.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/extensions/exception_extension.dart';
import '../repositories/auth_repository.dart';

class GetAccessTokenFromLocalUsecase implements UseCase<String, NoParams> {
  final AuthRepository repository;

  GetAccessTokenFromLocalUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    try {
      Log.info("GetAccessTokenFromLocalUsecase");
      final result = await repository.getAccessTokenFromLocal();
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
