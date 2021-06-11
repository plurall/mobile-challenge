class FailureSystem implements Exception {
  ErrorSystem type;
  String errorMessage;
  FailureSystem({this.type, this.errorMessage});
}

enum ErrorSystem { MESSAGE, CONNECTION, NOTFOUND }
