import 'package:mobile_challenge/app/modules/user/features/profile/domain/entities/user_detail_entity.dart';

import '../entities/user_favorite_entity.dart';


abstract class FavoritesRepository {
  Future<List<UserFavoriteEntity>> getFavorites();
  Future<bool> verifyFavorite(String userId);
  Future<bool> saveFavorite(UserFavoriteEntity user);
  Future<bool> removeFavorite(UserFavoriteEntity user);
}