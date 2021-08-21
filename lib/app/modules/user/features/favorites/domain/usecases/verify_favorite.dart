import '../repositories/favorites_repository.dart';

abstract class VerifyFavorite {
  Future<bool> verify(String login);
}

class VerifyFavoriteImpl implements VerifyFavorite {
  final FavoritesRepository repository;

  VerifyFavoriteImpl(this.repository);
  @override
  Future<bool> verify(String login) async {
    return await repository.verifyFavorite(login);
  }
}