import '../entities/user_detail_entity.dart';
import '../repositories/favorites_repository.dart';

abstract class RemoveFavorite {
  Future<bool> call(UserDetailEntity user);
}

class RemoveFavoriteImpl implements RemoveFavorite {
  final FavoritesRepository repository;

  RemoveFavoriteImpl(this.repository);
  @override
  Future<bool> call(UserDetailEntity user) async {
    return await repository.removeFavorite(user);
  }

}