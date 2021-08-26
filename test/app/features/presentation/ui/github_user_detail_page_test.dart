import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/config/service_locator_config.dart';
import 'package:mobile_challenge/app/core/usecase/usecase.dart';
import 'package:mobile_challenge/app/features/data/models/user_model.dart';
import 'package:mobile_challenge/app/features/domain/entities/user.dart';
import 'package:mobile_challenge/app/features/domain/usecases/get_favorites_users.dart';
import 'package:mobile_challenge/app/features/domain/usecases/get_user_data_by_username.dart';
import 'package:mobile_challenge/app/features/domain/usecases/save_favorite_user.dart';
import 'package:mobile_challenge/app/features/presentation/presenters/github_favorites/github_favorites_presenter.dart';
import 'package:mobile_challenge/app/features/presentation/presenters/github_favorites/github_favorites_presenter_impl.dart';
import 'package:mobile_challenge/app/features/presentation/presenters/github_user_detail/github_user_detail_presenter.dart';
import 'package:mobile_challenge/app/features/presentation/presenters/github_user_detail/github_user_detail_presenter_impl.dart';
import 'package:mobile_challenge/app/features/presentation/ui/github_user_detail_page.dart';
import 'package:mocktail/mocktail.dart';

class GetUserDataByUsernameMock extends Mock implements GetUserDataByUsername {}

class GetFavoritesUserMock extends Mock implements GetFavoritesUsers {}

class SaveFavoriteUserMock extends Mock implements SaveFavoriteUser {}

void main() {
  late GetUserDataByUsername getUserDataByUsername;
  late SaveFavoriteUser saveFavoriteUser;
  late GetFavoritesUsers getFavoritesUsers;
  late GithubUserDetailPresenter presenter;
  late GithubFavoritesPresenter favoritesPresenter;

  setUpAll(() {
    registerFallbackValue(
      SaveUserParams(
        user: User(username: 'AlexOliveira123'),
      ),
    );
    registerFallbackValue(UserParams(username: 'AlexOliveira123'));
    registerFallbackValue(NoParams());
  });

  setUp(() {
    getFavoritesUsers = GetFavoritesUserMock();
    saveFavoriteUser = SaveFavoriteUserMock();
    getUserDataByUsername = GetUserDataByUsernameMock();
    presenter = GithubUserDetailPresenterImpl(getUserDataByUsername);
    favoritesPresenter = GithubFavoritesPresenterImpl(
      saveFavoriteUser,
      getFavoritesUsers,
    );
    getIt.reset();
    getIt.registerFactory<GetFavoritesUsers>(() => getFavoritesUsers);
    getIt.registerFactory<SaveFavoriteUser>(() => saveFavoriteUser);
    getIt.registerFactory<GithubUserDetailPresenter>(() => presenter);
    getIt.registerFactory<GithubFavoritesPresenter>(() => favoritesPresenter);
  });

  Widget buildWidget(Widget widget) {
    return MaterialApp(home: widget);
  }

  testWidgets('Should load the page and set favorite our not on user',
      (tester) async {
    when(() => getUserDataByUsername(any())).thenAnswer((_) async =>
        Right(UserModel(username: 'AlexOliveira123', imageUrl: '')));
    when(() => getFavoritesUsers(any())).thenAnswer(
      (_) async => Right([User(username: 'AlexOliveira123')]),
    );
    when(() => saveFavoriteUser(any())).thenAnswer(
      (_) async => Right(true),
    );
    await tester.pumpWidget(
      buildWidget(GithubUserDetailPage(username: 'AlexOliveira123')),
    );
    await tester.pump();
    expect(favoritesPresenter.isFavorite, isTrue);
    final gestureDetector = find.byType(GestureDetector);
    expect(gestureDetector, findsOneWidget);
    await tester.tap(gestureDetector);
    expect(favoritesPresenter.isFavorite, isFalse);
    verify(() => getUserDataByUsername(any())).called(1);
    verify(() => getFavoritesUsers(any())).called(1);
    verify(() => saveFavoriteUser(any())).called(1);
  });
}
