import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/user/domain/repositories/favorites_repository.dart';
import 'package:mobile_challenge/app/modules/user/domain/usecases/save_favorite.dart';
import 'package:mobile_challenge/app/modules/user/data/models/user_detail_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_reader.dart';


class FavoritesRepositoryMock extends Mock implements FavoritesRepository {}
void main() {
  late final FavoritesRepositoryMock repository;
  late final SaveFavoriteImpl usecase;

  setUpAll(() {
    repository = FavoritesRepositoryMock();
    usecase = SaveFavoriteImpl(repository);
  });

  test('Should return success after save a new favorite', () async {
    final userJson = jsonDecode(fixture("single_user_favorite.json"));
    final user = UserDetailModel.fromJson(userJson).toEntity();    
    when(() => repository.saveFavorite(user)).thenAnswer((_) async => true);

    final result = await usecase(user);

    expect(result, equals(true));
  });
}