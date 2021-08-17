import 'package:mobile_challenge/app/modules/favorites/domain/entities/user_favorite.dart';

import '../favorites_repository.dart';

abstract class GetFavorites {
  Future<List<UserFavorite>> getFavorites();
}

class GetFavoritesImpl implements GetFavorites {
  final FavoritesRepository repository;

  GetFavoritesImpl(this.repository);
  @override
  Future<List<UserFavorite>> getFavorites() async {
    final favorites = await repository.getFavorites();
    return favorites;
  }

}