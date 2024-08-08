import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/doctor_by_name_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/repositories/doctor_repository.dart';

class GetDoctorByNameUsecase
    implements UseCase<List<DoctorByNameEntity>, String> {
  final DoctorRepository repository;

  GetDoctorByNameUsecase(this.repository);

  @override
  Future<Either<Failure, List<DoctorByNameEntity>>> call(String params) async {
    try {
      Log.info("GetDoctorByNameUsecase");
      final auth = await repository.getDoctorByName(params);
      Log.info('result: $auth');
      return Right(auth);
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
