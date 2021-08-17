import '../models/user_favorite_model.dart';

abstract class GetFavoritesDataSource {
  Future<List<UserFavoriteModel>> getFavorites();
}