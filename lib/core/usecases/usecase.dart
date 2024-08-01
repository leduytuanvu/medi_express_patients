import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/exception/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
