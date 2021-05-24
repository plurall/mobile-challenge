import 'package:flutter/material.dart';
import 'package:mobile_challenge/modules/favorites/data/datasources/favorites_remote_data_source.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

abstract class FavoritesRepositoryProtocol {
  Future<List<User>> getFavoritesList();
}

class FavoritesRepository implements FavoritesRepositoryProtocol {
  final FavoritesLocalDataSourceProtocol localDataSource;

  FavoritesRepository({
    @required this.localDataSource,
  });

  @override
  Future<List<User>> getFavoritesList() async {
    List<User> response = await localDataSource.getFavorites();
    return response;
  }
}
