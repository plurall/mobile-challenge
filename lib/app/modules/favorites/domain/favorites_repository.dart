import 'package:mobile_challenge/app/modules/favorites/domain/entities/user_favorite.dart';

abstract class FavoritesRepository {
  Future<List<UserFavorite>> getFavorites();
}