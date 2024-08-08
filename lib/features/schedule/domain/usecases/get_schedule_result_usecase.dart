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
import 'package:medi_express_patients/features/schedule/domain/entities/schedule_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/schedule_result_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/repositories/schedule_repository.dart';

class GetScheduleResultUsecase
    implements UseCase<ScheduleResultEntity, String> {
  final ScheduleRepository repository;

  GetScheduleResultUsecase(this.repository);

  @override
  Future<Either<Failure, ScheduleResultEntity>> call(String params) async {
    try {
      Log.info("GetScheduleResultUsecase");
      final result = await repository.getScheduleResult(params);
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
