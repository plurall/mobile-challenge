import 'package:flutter/material.dart';
import 'package:mobile_challenge/shared/datasources/favorites_local_data_source.dart';

abstract class FavoriteUserRepositoryProtocol {
  Future<bool> isFavorite(String nickname);
}

class FavoriteUserRepository implements FavoriteUserRepositoryProtocol {
  final FavoritesLocalDataSourceProtocol localDataSource;

  FavoriteUserRepository({
    @required this.localDataSource,
  });

  @override
  Future<bool> isFavorite(String nickname) async {
    return await localDataSource.isFavorite(nickname);
  }
}
