import 'package:mobile_challenge/app/modules/user/features/favorites/domain/usecases/verify_favorite.dart';

import '../../domain/entities/user_favorite_entity.dart';
import '../models/user_favorite_model.dart';

abstract class FavoritesDataSource {
  Future<List<UserFavoriteModel>> getFavorites();
  Future<bool> verifyFavorite(String userId);
  Future<bool> saveFavorite(UserFavoriteEntity user);
  Future<bool> removeFavorite(UserFavoriteEntity user);
}