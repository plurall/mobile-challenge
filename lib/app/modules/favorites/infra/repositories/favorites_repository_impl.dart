import 'package:mobile_challenge/app/modules/favorites/infra/datasources/favorites_datasource.dart';

import '../../domain/entities/user_favorite.dart';
import '../../domain/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesDataSource dataSource;

  FavoritesRepositoryImpl(this.dataSource);

  @override
  Future<List<UserFavorite>> getFavorites() async {
    final favorites = await dataSource.getFavorites();
    final favoritesToEntity = favorites.map((item) => item.toEntity()).toList();
    return favoritesToEntity;
  }

  @override
  Future<bool> saveFavorite(UserFavorite user) async {
    return await dataSource.saveFavorites(user);
  }

}