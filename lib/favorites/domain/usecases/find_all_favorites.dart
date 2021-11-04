import 'package:mobile_challenge/favorites/domain/repository/favorites_repository.dart';
import 'package:mobile_challenge/home/domain/entity/user.dart';

class FindAllFavorites {
  final FavoritesRepository _favoritesRepository;

  FindAllFavorites(this._favoritesRepository);

  Future<List<User>> execute() async {
    return await _favoritesRepository.findAll();
  }
}
