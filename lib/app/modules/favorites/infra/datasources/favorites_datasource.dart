import '../models/user_favorite_model.dart';

abstract class FavoritesDataSource {
  Future<List<UserFavoriteModel>> getFavorites();
}