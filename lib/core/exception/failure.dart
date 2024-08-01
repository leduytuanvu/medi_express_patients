import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String description;

  const Failure(
    this.message,
    this.description,
  );

  @override
  List<Object> get props => [message, description];
}

class LocalStorageFailure extends Failure {
  const LocalStorageFailure(
    super.message,
    super.description,
  );
}

class UnknownFailure extends Failure {
  const UnknownFailure(
    super.message,
    super.description,
  );
}

class ApiFailure extends Failure {
  const ApiFailure(
    super.message,
    super.description,
  );
}

class NetworkFailure extends Failure {
  const NetworkFailure(
    super.message,
    super.description,
  );
}

class FormatFailure extends Failure {
  const FormatFailure(
    super.message,
    super.description,
  );
}

class FileSystemFailure extends Failure {
  const FileSystemFailure(
    super.message,
    super.description,
  );
}

class InputOutputFailure extends Failure {
  const InputOutputFailure(
    super.message,
    super.description,
  );
}

class PlatformFailure extends Failure {
  const PlatformFailure(
    super.message,
    super.description,
  );
}

class StateFailure extends Failure {
  const StateFailure(
    super.message,
    super.description,
  );
}
