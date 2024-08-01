import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/features/auth/domain/entities/district_entity.dart';
import 'package:medi_express_patients/features/auth/domain/params/get_district_by_city_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/extensions/exception_extension.dart';
import '../repositories/auth_repository.dart';

class GetDistrictByCityUsecase
    implements UseCase<List<DistrictEntity>, GetDistrictByCityParams> {
  final AuthRepository repository;

  GetDistrictByCityUsecase(this.repository);

  @override
  Future<Either<Failure, List<DistrictEntity>>> call(
      GetDistrictByCityParams params) async {
    try {
      Log.info("GetDistrictByCityUsecase");
      final auth = await repository.getDistrictByCity(params.cityId);
      Log.info('result: $auth');
      return Right(auth);
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
