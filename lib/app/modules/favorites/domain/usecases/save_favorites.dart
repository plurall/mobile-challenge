import 'package:mobile_challenge/app/modules/favorites/domain/entities/user_favorite.dart';
import 'package:mobile_challenge/app/modules/favorites/domain/favorites_repository.dart';

abstract class SaveFavorites {
  Future<bool> saveUserFavorite(UserFavorite user);
}

class SaveFavoritesImpl implements SaveFavorites {
  final FavoritesRepository repository;

  SaveFavoritesImpl(this.repository);
  @override
  Future<bool> saveUserFavorite(UserFavorite user) async {
    return await repository.saveFavorite(user);
  }

}