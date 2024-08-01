class LocalStorageException implements Exception {}

class UnknownErrorException implements Exception {
  final String message;
  final String description;
  UnknownErrorException(
    this.message,
    this.description,
  );

  @override
  String toString() => description;
}

class ApiErrorException implements Exception {
  final String message;
  final String description;
  ApiErrorException(
    this.message,
    this.description,
  );

  @override
  String toString() => description;
}

class NetworkErrorException implements Exception {
  final String message;
  final String description;
  NetworkErrorException(
    this.message,
    this.description,
  );

  @override
  String toString() => description;
}

class FormatErrorException implements Exception {
  final String message;
  final String description;
  FormatErrorException(
    this.message,
    this.description,
  );

  @override
  String toString() => description;
}

class FileSystemErrorException implements Exception {
  final String message;
  final String description;
  FileSystemErrorException(
    this.message,
    this.description,
  );

  @override
  String toString() => description;
}

class InputOutputErrorException implements Exception {
  final String message;
  final String description;
  InputOutputErrorException(
    this.message,
    this.description,
  );

  @override
  String toString() => description;
}

class PlatformErrorException implements Exception {
  final String message;
  final String description;
  PlatformErrorException(
    this.message,
    this.description,
  );

  @override
  String toString() => description;
}

class StateErrorException implements Exception {
  final String message;
  final String description;
  StateErrorException(
    this.message,
    this.description,
  );

  @override
  String toString() => description;
}
