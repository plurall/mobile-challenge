import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/config/service_locator_config.dart';
import 'package:mobile_challenge/app/core/usecase/usecase.dart';
import 'package:mobile_challenge/app/features/data/models/user_model.dart';
import 'package:mobile_challenge/app/features/domain/entities/user.dart';
import 'package:mobile_challenge/app/features/domain/usecases/get_favorites_users.dart';
import 'package:mobile_challenge/app/features/domain/usecases/save_favorite_user.dart';
import 'package:mobile_challenge/app/features/presentation/presenters/github_favorites/github_favorites_presenter.dart';
import 'package:mobile_challenge/app/features/presentation/presenters/github_favorites/github_favorites_presenter_impl.dart';
import 'package:mobile_challenge/app/features/presentation/ui/github_favorites_page.dart';
import 'package:mocktail/mocktail.dart';

class GetFavoritesUserMock extends Mock implements GetFavoritesUsers {}

class SaveFavoriteUserMock extends Mock implements SaveFavoriteUser {}

void main() {
  late GetFavoritesUsers getFavoritesUsers;
  late SaveFavoriteUser saveFavoriteUser;
  late GithubFavoritesPresenter presenter;

  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  setUp(() {
    getFavoritesUsers = GetFavoritesUserMock();
    saveFavoriteUser = SaveFavoriteUserMock();
    presenter = GithubFavoritesPresenterImpl(
      saveFavoriteUser,
      getFavoritesUsers,
    );
    getIt.reset();
    getIt.registerFactory<GetFavoritesUsers>(() => getFavoritesUsers);
    getIt.registerFactory<SaveFavoriteUser>(() => saveFavoriteUser);
    getIt.registerFactory<GithubFavoritesPresenter>(() => presenter);
  });

  Widget buildWidget(Widget widget) {
    return MaterialApp(home: widget);
  }

  testWidgets('Should load the users favorite list', (tester) async {
    when(() => getFavoritesUsers(any())).thenAnswer(
      (_) async => Right(<User>[
        UserModel(username: 'AlexOliveira123'),
        UserModel(username: 'any_user'),
      ]),
    );
    await tester.pumpWidget(
      buildWidget(GithubFavoritesPage()),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump();
    expect(find.byType(ListTile), findsNWidgets(2));
    verify(() => getFavoritesUsers(any())).called(1);
  });

  testWidgets('Should show message: Favorite List is empty.', (tester) async {
    when(() => getFavoritesUsers(any())).thenAnswer(
      (_) async => Right(<User>[]),
    );
    await tester.pumpWidget(
      buildWidget(GithubFavoritesPage()),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump();
    expect(
      find.text('Lista de favoritos vazia.'),
      findsOneWidget,
    );
    verify(() => getFavoritesUsers(any())).called(1);
  });
}
