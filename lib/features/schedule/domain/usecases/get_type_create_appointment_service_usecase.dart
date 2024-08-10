import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/type_create_appointment_service_entity.dart';
import 'package:medi_express_patients/features/schedule/domain/repositories/schedule_repository.dart';

class GetTypeCreateAppointmentServiceUsecase
    implements UseCase<List<TypeCreateAppointmentServiceEntity>, NoParams> {
  final ScheduleRepository repository;

  GetTypeCreateAppointmentServiceUsecase(this.repository);

  @override
  Future<Either<Failure, List<TypeCreateAppointmentServiceEntity>>> call(
      NoParams params) async {
    try {
      Log.info("GetTypeCreateAppointmentServiceUsecase");
      final result = await repository.getTypeCreateAppointmentService();
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
