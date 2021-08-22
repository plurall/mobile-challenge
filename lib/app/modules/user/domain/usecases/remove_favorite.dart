import '../entities/user_entity.dart';
import '../repositories/favorites_repository.dart';

abstract class RemoveFavorite {
  Future<bool> call(UserEntity user);
}

class RemoveFavoriteImpl implements RemoveFavorite {
  final FavoritesRepository repository;

  RemoveFavoriteImpl(this.repository);
  @override
  Future<bool> call(UserEntity user) async {
    return await repository.removeFavorite(user);
  }

}