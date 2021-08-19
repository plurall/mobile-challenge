import '../entities/user_favorite_entity.dart';
import '../favorites_repository.dart';

abstract class RemoveFavorites {
  Future<bool> removeUserFavorite(UserFavoriteEntity user);
}

class RemoveFavoritesImpl implements RemoveFavorites {
  final FavoritesRepository repository;

  RemoveFavoritesImpl(this.repository);
  @override
  Future<bool> removeUserFavorite(UserFavoriteEntity user) async {
    return await repository.removeFavorite(user);
  }

}