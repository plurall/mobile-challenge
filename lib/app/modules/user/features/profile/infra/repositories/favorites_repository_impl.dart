import '../../domain/entities/user_detail_entity.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_datasource.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesDataSource dataSource;

  FavoritesRepositoryImpl(this.dataSource);

  @override
  Future<List<UserDetailEntity>> getFavorites() async {
    final favorites = await dataSource.getFavorites();
    final favoritesToEntity = favorites.map((item) => item.toEntity()).toList();
    return favoritesToEntity;
  }

  @override
  Future<bool> verifyFavorite(UserDetailEntity user) async {
    return await dataSource.verifyFavorite(user);
  }

  @override
  Future<bool> saveFavorite(UserDetailEntity user) async {
    return await dataSource.saveFavorite(user);
  }

  @override
  Future<bool> removeFavorite(UserDetailEntity user) async {
    return await dataSource.removeFavorite(user);
  }


}