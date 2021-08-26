import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/usecase/usecase.dart';
import 'package:mobile_challenge/app/features/data/models/user_model.dart';
import 'package:mobile_challenge/app/features/domain/entities/user.dart';
import 'package:mobile_challenge/app/features/domain/usecases/get_favorites_users.dart';
import 'package:mobile_challenge/app/features/domain/usecases/save_favorite_user.dart';
import 'package:mobile_challenge/app/features/presentation/presenters/github_favorites/github_favorites_presenter_impl.dart';
import 'package:mocktail/mocktail.dart';

class SaveFavoriteUserMock extends Mock implements SaveFavoriteUser {}

class GetFavoritesUsersMock extends Mock implements GetFavoritesUsers {}

void main() {
  final saveFavoriteUser = SaveFavoriteUserMock();
  final getFavoritesUsers = GetFavoritesUsersMock();
  final presenter = GithubFavoritesPresenterImpl(
    saveFavoriteUser,
    getFavoritesUsers,
  );

  setUpAll(() {
    registerFallbackValue(
      SaveUserParams(user: User(username: 'AlexOliveira123')),
    );
    registerFallbackValue(
      NoParams(),
    );
  });

  test('Should save favorite user with success', () async {
    when(() => saveFavoriteUser(any())).thenAnswer((_) async => Right(true));
    expect(presenter.isFavorite, isFalse);
    await presenter.setFavorite('AlexOliveira123');
    expect(presenter.isFavorite, isTrue);
    verify(() => saveFavoriteUser(any())).called(1);
  });

  test('Should get the favorite users with success', () async {
    when(() => getFavoritesUsers(any())).thenAnswer(
        (_) async => Right(<User>[UserModel(username: 'AlexOliveira123')]));
    expect(presenter.favoritesUsersList, isNull);
    await presenter.getFavoritesUsers();
    expect(presenter.favoritesUsersList!.length, equals(1));
    verify(() => getFavoritesUsers(any())).called(1);
  });
}
