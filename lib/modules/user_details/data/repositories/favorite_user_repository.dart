import 'package:flutter/material.dart';
import 'package:mobile_challenge/shared/datasources/favorites_local_data_source.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

abstract class FavoriteUserRepositoryProtocol {
  Future<bool> isFavorite(String nickname);
  Future<bool> toggleFavorite(User user);
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

  @override
  Future<bool> toggleFavorite(User user) async {
    return await localDataSource.toggleFavorite(user);
  }
}
