import '../entities/user_favorite_entity.dart';


abstract class FavoritesRepository {
  Future<List<UserFavoriteEntity>> getFavorites();
  Future<bool> saveFavorite(UserFavoriteEntity user);
  Future<bool> removeFavorite(UserFavoriteEntity user);
}