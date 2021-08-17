import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/favorites/domain/favorites_repository.dart';
import 'package:mobile_challenge/app/modules/favorites/domain/usecases/save_favorites.dart';
import 'package:mobile_challenge/app/modules/favorites/infra/models/user_favorite_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_reader.dart';

class FavoritesRepositoryMock extends Mock implements FavoritesRepository {}
void main() {
  late final FavoritesRepositoryMock repository;
  late final SaveFavoritesImpl usecase;

  setUpAll(() {
    repository = FavoritesRepositoryMock();
    usecase = SaveFavoritesImpl(repository);
  });

  test('Should return success after save a new favorite', () async {
    final userJson = jsonDecode(fixture("single_user_favorite.json"));
    final user = UserFavoriteModel.fromJson(userJson).toEntity();    
    when(() => repository.saveFavorite(user)).thenAnswer((_) async => true);

    final result = await usecase.saveUserFavorite(user);

    expect(result, equals(true));
  });
}