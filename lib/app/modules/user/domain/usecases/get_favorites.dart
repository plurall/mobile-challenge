import '../entities/user_entity.dart';
import '../repositories/favorites_repository.dart';

abstract class GetFavorites {
  Future<List<UserEntity>> call();
}

class GetFavoritesImpl implements GetFavorites {
  final FavoritesRepository repository;

  GetFavoritesImpl(this.repository);
  @override
  Future<List<UserEntity>> call() async {
    final favorites = await repository.getFavorites();
    return favorites;
  }

}