import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/create_appointment_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/params/create_appointment_params.dart';
import 'package:medi_express_patients/features/schedule/domain/repositories/schedule_repository.dart';

class CreateAppointmentUsecase
    implements UseCase<CreateAppointmentEntity, CreateAppointmentParams> {
  final ScheduleRepository repository;

  CreateAppointmentUsecase(this.repository);

  @override
  Future<Either<Failure, CreateAppointmentEntity>> call(
      CreateAppointmentParams params) async {
    try {
      Log.info("CreateAppointmentUsecase");
      final result = await repository.createAppointment(params);
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
