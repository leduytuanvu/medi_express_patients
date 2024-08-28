import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/doctor/domain/params/create_apointment_id_params.dart';
import 'package:medi_express_patients/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/create_appointment_entity.dart';

class CreateAppointmentIdUsecase
    implements UseCase<CreateAppointmentEntity, CreateAppointmentIdParams> {
  final DoctorRepository repository;

  CreateAppointmentIdUsecase(this.repository);

  @override
  Future<Either<Failure, CreateAppointmentEntity>> call(
      CreateAppointmentIdParams params) async {
    try {
      Log.info("CreateAppointmentIdUsecase");
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
