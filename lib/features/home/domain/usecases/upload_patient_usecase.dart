import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/home/domain/entities/upload_patient_entity.dart';
import 'package:medi_express_patients/features/home/domain/params/upload_patient_params.dart';
import 'package:medi_express_patients/features/home/domain/repositories/home_repository.dart';

class UploadPatientUsecase
    implements UseCase<UploadPatientEntity, UploadPatientParams> {
  final HomeRepository repository;

  UploadPatientUsecase(this.repository);

  @override
  Future<Either<Failure, UploadPatientEntity>> call(
      UploadPatientParams params) async {
    try {
      Log.info("UploadPatientUsecase");
      final result = await repository.uploadPatient(params);
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
