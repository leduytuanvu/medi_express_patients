import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/features/auth/domain/entities/city_entity.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/extensions/exception_extension.dart';
import '../repositories/auth_repository.dart';

class GetAllCityUsecase implements UseCase<List<CityEntity>, NoParams> {
  final AuthRepository repository;

  GetAllCityUsecase(this.repository);

  @override
  Future<Either<Failure, List<CityEntity>>> call(NoParams params) async {
    try {
      Log.info("GetAllCityUsecase");
      final result = await repository.getAllCity();
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
