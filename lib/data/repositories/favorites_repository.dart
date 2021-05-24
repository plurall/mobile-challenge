import 'package:flutter/material.dart';
import 'package:mobile_challenge/shared/datasources/favorites_local_data_source.dart';
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
