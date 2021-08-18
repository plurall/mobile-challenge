import 'package:mobile_challenge/app/modules/favorites/domain/entities/user_favorite.dart';

import '../models/user_favorite_model.dart';

abstract class FavoritesDataSource {
  Future<List<UserFavoriteModel>> getFavorites();
  Future<bool> saveFavorite(UserFavorite user);
  Future<bool> removeFavorite(UserFavorite user);
}