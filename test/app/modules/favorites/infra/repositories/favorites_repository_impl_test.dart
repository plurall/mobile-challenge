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
  late UserFavorite tUser;

  setUpAll(() {
    datasource = FavoritesDataSourceMock();
    repository = FavoritesRepositoryImpl(datasource);
    final userJson = jsonDecode(fixture("single_user_favorite.json"));
    tUser = UserFavoriteModel.fromMap(userJson).toEntity();  
  });

  test('Should return a list of UserFavorites', () async {     
    when(() => datasource.getFavorites()).thenAnswer((_) async => <UserFavoriteModel>[]);

    final result = await repository.getFavorites();

    expect(result, isA<List<UserFavorite>>());
  });

  test('Should return true if favorite was successfully saved', () async {
    when(() => datasource.saveFavorite(tUser)).thenAnswer((_) async => true);

    final result = await repository.saveFavorite(tUser);

    expect(result, equals(true));
  });

  test('Should return true if favorite was successfully removed', () async {
    when(() => datasource.removeFavorite(tUser)).thenAnswer((_) async => true);

    final result = await repository.removeFavorite(tUser);

    expect(result, equals(true));
  });
}