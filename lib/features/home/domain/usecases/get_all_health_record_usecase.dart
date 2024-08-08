import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/auth/domain/params/change_password_params.dart';
import 'package:medi_express_patients/features/auth/domain/repositories/auth_repository.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/doctor_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:medi_express_patients/features/home/domain/entities/health_record_entity.dart';
import 'package:medi_express_patients/features/home/domain/repositories/home_repository.dart';

class GetAllHealthRecordUsecase
    implements UseCase<List<HealthRecordEntity>, NoParams> {
  final HomeRepository repository;

  GetAllHealthRecordUsecase(this.repository);

  @override
  Future<Either<Failure, List<HealthRecordEntity>>> call(
      NoParams params) async {
    try {
      Log.info("GetAllHealthRecordUsecase");
      final result = await repository.getAllHealthRecord();
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
