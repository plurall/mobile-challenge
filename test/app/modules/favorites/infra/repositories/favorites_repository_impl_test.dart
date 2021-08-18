import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/favorites/domain/entities/user_favorite.dart';
import 'package:mobile_challenge/app/modules/favorites/infra/datasources/favorites_datasource.dart';
import 'package:mobile_challenge/app/modules/favorites/infra/models/user_favorite_model.dart';
import 'package:mobile_challenge/app/modules/favorites/infra/repositories/favorites_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_reader.dart';

class FavoritesDataSourceMock extends Mock implements FavoritesDataSource {}

void main() {
  late final FavoritesDataSourceMock datasource;
  late final FavoritesRepositoryImpl repository;

  setUpAll(() {
    datasource = FavoritesDataSourceMock();
    repository = FavoritesRepositoryImpl(datasource);
  });

  test('Should return a list of UserFavorites', () async {     
    when(() => datasource.getFavorites()).thenAnswer((_) async => <UserFavoriteModel>[]);

    final result = await repository.getFavorites();

    expect(result, isA<List<UserFavorite>>());
  });

  test('Should return true if favorite was successfully saved', () async {
    final userJson = jsonDecode(fixture("single_user_favorite.json"));
    final user = UserFavoriteModel.fromMap(userJson).toEntity();    
    when(() => datasource.saveFavorite(user)).thenAnswer((_) async => true);

    final result = await repository.saveFavorite(user);

    expect(result, equals(true));
  });

  test('Should return true if favorite was successfully removed', () async {
    final userJson = jsonDecode(fixture("single_user_favorite.json"));
    final user = UserFavoriteModel.fromMap(userJson).toEntity();    
    when(() => datasource.removeFavorite(user)).thenAnswer((_) async => true);

    final result = await repository.removeFavorite(user);

    expect(result, equals(true));
  });
}