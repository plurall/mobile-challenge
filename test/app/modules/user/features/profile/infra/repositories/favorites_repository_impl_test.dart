import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/domain/entities/user_detail_entity.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/datasources/favorites_datasource.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/models/user_detail_model.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/models/users_favorite_model.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/repositories/favorites_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/fixture_reader.dart';

class FavoritesDataSourceMock extends Mock implements FavoritesDataSource {}

void main() {
  late final FavoritesDataSourceMock datasource;
  late final FavoritesRepositoryImpl repository;
  late UserDetailEntity tUser;
  final UsersFavoriteModel tUserList = UsersFavoriteModel
      .fromMap(jsonDecode(fixture("user_favorites_list.json")));

  setUpAll(() {
    datasource = FavoritesDataSourceMock();
    repository = FavoritesRepositoryImpl(datasource);
    final userJson = jsonDecode(fixture("single_user_favorite.json"));
    tUser = UserDetailModel.fromJson(userJson).toEntity();  
  });

  test('Should return a list of favorites', () async {     
    when(() => datasource.getFavorites()).thenAnswer((_) async => tUserList.favorites);

    final result = await repository.getFavorites();

    expect(result, isA<List<UserDetailEntity>>());
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