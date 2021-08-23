abstract class ProfileErrors implements Exception {}

class InvalidUserName implements ProfileErrors {}

class UnauthorizedError implements ProfileErrors {}

class ProfileCacheException implements ProfileErrors {}