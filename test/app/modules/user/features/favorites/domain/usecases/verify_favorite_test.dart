import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/user/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:mobile_challenge/app/modules/user/features/favorites/domain/usecases/verify_favorite.dart';
import 'package:mocktail/mocktail.dart';

class FavoriteUserRepositoryMock extends Mock implements FavoritesRepository {}
void main() {
  late final FavoriteUserRepositoryMock repository;
  late final VerifyFavorite usecase;

  setUpAll(() {
    repository = FavoriteUserRepositoryMock();
    usecase = VerifyFavoriteImpl(repository);
  });

  test('Should return true if a user is already a favorite', () async {
  });
}