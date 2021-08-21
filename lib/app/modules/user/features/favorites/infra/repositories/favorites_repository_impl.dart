import '../../domain/entities/user_favorite_entity.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_datasource.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesDataSource dataSource;

  FavoritesRepositoryImpl(this.dataSource);

  @override
  Future<List<UserFavoriteEntity>> getFavorites() async {
    final favorites = await dataSource.getFavorites();
    final favoritesToEntity = favorites.map((item) => item.toEntity()).toList();
    return favoritesToEntity;
  }

  @override
  Future<bool> verifyFavorite(String login) async {
    return await dataSource.verifyFavorite(login);
  }

  @override
  Future<bool> saveFavorite(UserFavoriteEntity user) async {
    return await dataSource.saveFavorite(user);
  }

  @override
  Future<bool> removeFavorite(UserFavoriteEntity user) async {
    return await dataSource.removeFavorite(user);
  }


}