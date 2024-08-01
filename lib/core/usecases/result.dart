import 'package:medi_express_patients/core/exception/failure.dart';

class Result<T> {
  final T data;
  final Failure? failure;

  Result.success(this.data) : failure = null;
  Result.failure(this.failure) : data = null as T;
}
