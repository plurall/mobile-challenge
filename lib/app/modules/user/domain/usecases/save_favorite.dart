
import '../entities/user_entity.dart';
import '../repositories/favorites_repository.dart';

abstract class SaveFavorite {
  Future<bool> call(UserEntity user);
}

class SaveFavoriteImpl implements SaveFavorite {
  final FavoritesRepository repository;

  SaveFavoriteImpl(this.repository);
  @override
  Future<bool> call(UserEntity user) async {
    return await repository.saveFavorite(user);
  }

}