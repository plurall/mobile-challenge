import '../entities/user_detail_entity.dart';
import '../repositories/favorites_repository.dart';

abstract class GetFavorites {
  Future<List<UserDetailEntity>> call();
}

class GetFavoritesImpl implements GetFavorites {
  final FavoritesRepository repository;

  GetFavoritesImpl(this.repository);
  @override
  Future<List<UserDetailEntity>> call() async {
    final favorites = await repository.getFavorites();
    return favorites;
  }

}