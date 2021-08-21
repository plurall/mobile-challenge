abstract class FavoriteErrors implements Exception {}

class FavoriteAlreadyExists implements FavoriteErrors {}

class FavoriteDoesntExists implements FavoriteErrors {}