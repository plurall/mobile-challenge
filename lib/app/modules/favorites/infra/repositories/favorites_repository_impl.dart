import 'package:mobile_challenge/app/modules/favorites/infra/datasources/get_favorites_datasource.dart';

import '../../domain/entities/user_favorite.dart';
import '../../domain/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final GetFavoritesDataSource dataSource;

  FavoritesRepositoryImpl(this.dataSource);

  @override
  Future<List<UserFavorite>> getFavorites() async {
    final favorites = await dataSource.getFavorites();
    final favoritesToEntity = favorites.map((item) => item.toEntity()).toList();
    return favoritesToEntity;
  }

}