import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/auth/domain/entities/create_medical_history_entity.dart';
import 'package:medi_express_patients/features/auth/domain/params/create_medical_history_params.dart';
import 'package:medi_express_patients/features/auth/domain/repositories/auth_repository.dart';

class CreateMedicalHistoryUsecase
    implements UseCase<CreateMedicalHistoryEntity, CreateMedicalHistoryParams> {
  final AuthRepository repository;

  CreateMedicalHistoryUsecase(this.repository);

  /// Calls the login use case with the provided [params].
  /// Returns a [Future] that resolves to an [Either] containing a [Failure] or a [UserEntity].
  @override
  Future<Either<Failure, CreateMedicalHistoryEntity>> call(
      CreateMedicalHistoryParams params) async {
    try {
      Log.info("CreateMedicalHistoryUsecase");
      final result = await repository.createMedicalHistory(
        params.patientId,
        params.hypertension,
        params.diabetes,
        params.heartDisease,
        params.stroke,
        params.asthma,
        params.epilepsy,
        params.copd,
        params.palpitations,
        params.otherMedicalHistory,
      );
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
