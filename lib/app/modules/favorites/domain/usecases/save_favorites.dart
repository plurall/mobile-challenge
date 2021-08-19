import '../entities/user_favorite_entity.dart';
import '../favorites_repository.dart';

abstract class SaveFavorites {
  Future<bool> saveUserFavorite(UserFavoriteEntity user);
}

class SaveFavoritesImpl implements SaveFavorites {
  final FavoritesRepository repository;

  SaveFavoritesImpl(this.repository);
  @override
  Future<bool> saveUserFavorite(UserFavoriteEntity user) async {
    return await repository.saveFavorite(user);
  }

}