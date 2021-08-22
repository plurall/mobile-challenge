import '../entities/user_entity.dart';


abstract class FavoritesRepository {
  Future<List<UserEntity>> getFavorites();
  Future<bool> verifyFavorite(UserEntity user);
  Future<bool> saveFavorite(UserEntity user);
  Future<bool> removeFavorite(UserEntity user);
}