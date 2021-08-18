import '../entities/user_favorite.dart';
import '../favorites_repository.dart';

abstract class RemoveFavorites {
  Future<bool> removeUserFavorite(UserFavorite user);
}

class RemoveFavoritesImpl implements RemoveFavorites {
  final FavoritesRepository repository;

  RemoveFavoritesImpl(this.repository);
  @override
  Future<bool> removeUserFavorite(UserFavorite user) async {
    return await repository.removeFavorite(user);
  }

}