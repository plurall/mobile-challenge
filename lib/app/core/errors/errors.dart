abstract class Failure implements Exception {
  final String? message;

  Failure(this.message);
}

class InvalidTextFailure extends Failure {
  InvalidTextFailure({String? message}) : super(message);
}

class InvalidUsernameFailure extends Failure {
  InvalidUsernameFailure({String? message}) : super(message);
}

class DatasourceError extends Failure {
  DatasourceError({String? message}) : super(message);
}

class CacheError extends Failure {
  CacheError({String? message}) : super(message);
}
