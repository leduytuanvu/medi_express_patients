import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/schedule_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/params/get_all_schedule_params.dart';
import 'package:medi_express_patients/features/schedule/domain/repositories/schedule_repository.dart';

class GetAllScheduleUsecase
    implements UseCase<List<ScheduleEntity>, GetAllScheduleParams> {
  final ScheduleRepository repository;

  GetAllScheduleUsecase(this.repository);

  @override
  Future<Either<Failure, List<ScheduleEntity>>> call(
      GetAllScheduleParams params) async {
    try {
      Log.info("GetAllScheduleUsecase");
      final result =
          await repository.getAllSchedule(params.status, params.patientId);
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
