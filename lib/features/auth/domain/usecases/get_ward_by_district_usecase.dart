import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/features/auth/domain/entities/ward_entity.dart';
import 'package:medi_express_patients/features/auth/domain/params/get_ward_by_district_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/extensions/exception_extension.dart';
import '../repositories/auth_repository.dart';

class GetWardByDistrictUsecase
    implements UseCase<List<WardEntity>, GetWardByDistrictParams> {
  final AuthRepository repository;

  GetWardByDistrictUsecase(this.repository);

  @override
  Future<Either<Failure, List<WardEntity>>> call(
      GetWardByDistrictParams params) async {
    try {
      Log.info("GetWardByDistrictParams");
      final auth = await repository.getWardByDistrict(params.districtId);
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
