import '../entities/user_entity.dart';
import '../repositories/favorites_repository.dart';

abstract class VerifyFavorite {
  Future<bool> call(UserEntity user);
}

class VerifyFavoriteImpl implements VerifyFavorite {
  final FavoritesRepository repository;

  VerifyFavoriteImpl(this.repository);
  @override
  Future<bool> call(UserEntity user) async {
    return await repository.verifyFavorite(user);
  }
}