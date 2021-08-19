import '../entities/user_favorite_entity.dart';
import '../repositories/favorites_repository.dart';

abstract class RemoveFavorite {
  Future<bool> removeUserFavorite(UserFavoriteEntity user);
}

class RemoveFavoriteImpl implements RemoveFavorite {
  final FavoritesRepository repository;

  RemoveFavoriteImpl(this.repository);
  @override
  Future<bool> removeUserFavorite(UserFavoriteEntity user) async {
    return await repository.removeFavorite(user);
  }

}