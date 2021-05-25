abstract class FailureSearchUser implements Exception {}

class InvalidTextError implements FailureSearchUser {}

class DatasourceError implements FailureSearchUser {}
