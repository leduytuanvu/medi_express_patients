import 'package:medi_express_patients/core/exception/exceptions.dart';
import 'package:medi_express_patients/core/exception/failure.dart';

extension ExceptionMapping on Exception {
  Failure toFailure() {
    if (this is LocalStorageException) {
      final ex = this as ApiErrorException;
      return LocalStorageFailure(ex.message, ex.description);
    } else if (this is UnknownErrorException) {
      final ex = this as UnknownErrorException;
      return UnknownFailure(ex.message, ex.description);
    } else if (this is ApiErrorException) {
      final ex = this as ApiErrorException;
      return ApiFailure(ex.message, ex.description);
    } else if (this is NetworkErrorException) {
      final ex = this as NetworkErrorException;
      return NetworkFailure(ex.message, ex.description);
    } else if (this is FormatErrorException) {
      final ex = this as FormatErrorException;
      return FormatFailure(ex.message, ex.description);
    } else if (this is FileSystemErrorException) {
      final ex = this as FileSystemErrorException;
      return FileSystemFailure(ex.message, ex.description);
    } else if (this is InputOutputErrorException) {
      final ex = this as InputOutputErrorException;
      return InputOutputFailure(ex.message, ex.description);
    } else if (this is PlatformErrorException) {
      final ex = this as PlatformErrorException;
      return PlatformFailure(ex.message, ex.description);
    } else if (this is StateErrorException) {
      final ex = this as StateErrorException;
      return StateFailure(ex.message, ex.description);
    } else {
      return const UnknownFailure('Unknown Error', 'An unknown error occurred');
    }
  }
}
