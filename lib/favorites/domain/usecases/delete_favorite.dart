import 'package:mobile_challenge/favorites/domain/repository/favorites_repository.dart';
import 'package:mobile_challenge/home/domain/entity/user.dart';

class DeleteFavorite {
  final FavoritesRepository _favoritesRepository;

  DeleteFavorite(this._favoritesRepository);

  Future<void> execute(User user) async {
    try {
      return await _favoritesRepository.delete(user);
    } catch (e) {
      throw e;
    }
  }
}
