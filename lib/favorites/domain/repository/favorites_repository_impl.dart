import 'package:mobile_challenge/favorites/data/favorites_datasource.dart';
import 'package:mobile_challenge/favorites/domain/repository/favorites_repository.dart';
import 'package:mobile_challenge/home/domain/entity/user.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesDatasource _favoritesDatasource;

  FavoritesRepositoryImpl(this._favoritesDatasource);

  @override
  Future<List<User>> findAll() async {
    try {
      return await _favoritesDatasource.findAll();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> save(User user) async {
    try {
      await _favoritesDatasource.save(user);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> delete(User user) async {
    try {
      await _favoritesDatasource.delete(user);
    } catch (e) {
      throw e;
    }
  }
}
