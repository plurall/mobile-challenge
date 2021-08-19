import '../entities/user_favorite_entity.dart';
import '../repositories/favorites_repository.dart';

abstract class GetFavorites {
  Future<List<UserFavoriteEntity>> getFavorites();
}

class GetFavoritesImpl implements GetFavorites {
  final FavoritesRepository repository;

  GetFavoritesImpl(this.repository);
  @override
  Future<List<UserFavoriteEntity>> getFavorites() async {
    final favorites = await repository.getFavorites();
    return favorites;
  }

}