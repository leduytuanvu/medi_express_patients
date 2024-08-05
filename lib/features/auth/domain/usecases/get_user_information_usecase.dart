import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/features/auth/domain/entities/user_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/ward_entity.dart';
import 'package:medi_express_patients/features/auth/domain/params/get_ward_by_district_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/extensions/exception_extension.dart';
import '../repositories/auth_repository.dart';

class GetUserInformationUsecase
    implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  GetUserInformationUsecase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(
      NoParams params) async {
    try {
      Log.info("GetUserInformationUsecase");
      final result = await repository.getUserInformation();
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
