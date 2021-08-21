import '../entities/user_detail_entity.dart';


abstract class FavoritesRepository {
  Future<List<UserDetailEntity>> getFavorites();
  Future<bool> verifyFavorite(UserDetailEntity user);
  Future<bool> saveFavorite(UserDetailEntity user);
  Future<bool> removeFavorite(UserDetailEntity user);
}