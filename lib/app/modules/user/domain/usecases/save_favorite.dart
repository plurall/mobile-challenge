
import '../entities/user_detail_entity.dart';
import '../repositories/favorites_repository.dart';

abstract class SaveFavorite {
  Future<bool> call(UserDetailEntity user);
}

class SaveFavoriteImpl implements SaveFavorite {
  final FavoritesRepository repository;

  SaveFavoriteImpl(this.repository);
  @override
  Future<bool> call(UserDetailEntity user) async {
    return await repository.saveFavorite(user);
  }

}