abstract class FavoriteErrors implements Exception {}

class EmptyFavoritesEception implements FavoriteErrors {}

class FavoriteAlreadyExists implements FavoriteErrors {}

class FavoriteDoesntExists implements FavoriteErrors {}