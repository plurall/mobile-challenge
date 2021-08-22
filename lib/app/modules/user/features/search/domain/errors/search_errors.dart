abstract class SearchErrors implements Exception {}

class InvalidSearchText implements SearchErrors {}

class UnavailableServiceError implements SearchErrors {}

class ServerFailure implements SearchErrors {}