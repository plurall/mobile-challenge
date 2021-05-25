import 'package:flutter/material.dart';
import 'package:mobile_challenge/shared/datasources/favorites_local_data_source.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

abstract class FavoriteUserRepositoryProtocol {
  Future<bool> isFavorite(String nickname);
  Future<User> toggleFavorite(User user);
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
  Future<User> toggleFavorite(User user) async {
    user.favorite = !user.favorite;
    return await localDataSource.toggleFavorite(user);
  }
}
