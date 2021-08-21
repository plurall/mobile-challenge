import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/user/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:mobile_challenge/app/modules/user/features/favorites/domain/usecases/remove_favorite.dart';
import 'package:mobile_challenge/app/modules/user/features/favorites/infra/models/user_favorite_model.dart';

import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/fixture_reader.dart';

class FavoritesRepositoryMock extends Mock implements FavoritesRepository {}
void main() {
  late final FavoritesRepositoryMock repository;
  late final RemoveFavoriteImpl usecase;

  setUpAll(() {
    repository = FavoritesRepositoryMock();
    usecase = RemoveFavoriteImpl(repository);
  });

  test('Should return success after remove an existing favorite', () async {
    final userJson = jsonDecode(fixture("single_user_favorite.json"));
    final user = UserFavoriteModel.fromMap(userJson).toEntity();    
    when(() => repository.removeFavorite(user)).thenAnswer((_) async => true);

    final result = await usecase.removeUserFavorite(user);

    expect(result, equals(true));
  });
}