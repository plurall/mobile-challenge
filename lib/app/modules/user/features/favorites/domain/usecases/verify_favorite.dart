import '../repositories/favorites_repository.dart';

abstract class VerifyFavorite {
  Future<bool> verify(String userId);
}

class VerifyFavoriteImpl implements VerifyFavorite {
  final FavoritesRepository repository;

  VerifyFavoriteImpl(this.repository);
  @override
  Future<bool> verify(String userId) async {
    return await repository.verifyFavorite(userId);
  }
}