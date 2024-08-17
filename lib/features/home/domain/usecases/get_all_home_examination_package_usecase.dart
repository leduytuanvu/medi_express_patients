import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/home/domain/entities/home_examination_package_entity.dart';
import 'package:medi_express_patients/features/home/domain/repositories/home_repository.dart';

class GetAllHomeExaminationPackageUsecase
    implements UseCase<List<HomeExaminationPackageEntity>, NoParams> {
  final HomeRepository repository;

  GetAllHomeExaminationPackageUsecase(this.repository);

  @override
  Future<Either<Failure, List<HomeExaminationPackageEntity>>> call(
      NoParams params) async {
    try {
      Log.info("GetAllHomeExaminationPackageUsecase");
      final result = await repository.getListHomeExaminationPackage();
      Log.info('result: $result');
      return Right(result);
    } catch (error) {
      Log.info('error result: $error');
      if (error is Exception) {
        return Left(error.toFailure());
      } else {
        return Left(UnknownFailure('Unknown error', error.toString()));
      }
    }
  }
}
