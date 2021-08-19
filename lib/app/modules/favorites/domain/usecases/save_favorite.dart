import '../entities/user_favorite_entity.dart';
import '../repositories/favorites_repository.dart';

abstract class SaveFavorite {
  Future<bool> saveUserFavorite(UserFavoriteEntity user);
}

class SaveFavoriteImpl implements SaveFavorite {
  final FavoritesRepository repository;

  SaveFavoriteImpl(this.repository);
  @override
  Future<bool> saveUserFavorite(UserFavoriteEntity user) async {
    return await repository.saveFavorite(user);
  }

}