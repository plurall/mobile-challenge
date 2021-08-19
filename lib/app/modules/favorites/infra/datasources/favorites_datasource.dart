import '../../domain/entities/user_favorite_entity.dart';
import '../models/user_favorite_model.dart';

abstract class FavoritesDataSource {
  Future<List<UserFavoriteModel>> getFavorites();
  Future<bool> saveFavorite(UserFavoriteEntity user);
  Future<bool> removeFavorite(UserFavoriteEntity user);
}