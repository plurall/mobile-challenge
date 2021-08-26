import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/config/service_locator_config.dart';
import 'package:mobile_challenge/app/core/usecase/usecase.dart';
import 'package:mobile_challenge/app/features/data/models/result_search_model.dart';
import 'package:mobile_challenge/app/features/domain/usecases/get_favorites_users.dart';
import 'package:mobile_challenge/app/features/domain/usecases/save_favorite_user.dart';
import 'package:mobile_challenge/app/features/domain/usecases/search_by_text.dart';
import 'package:mobile_challenge/app/features/presentation/presenters/github_favorites/github_favorites_presenter.dart';
import 'package:mobile_challenge/app/features/presentation/presenters/github_favorites/github_favorites_presenter_impl.dart';
import 'package:mobile_challenge/app/features/presentation/presenters/github_search/github_search_presenter.dart';
import 'package:mobile_challenge/app/features/presentation/presenters/github_search/github_search_presenter_impl.dart';
import 'package:mobile_challenge/app/features/presentation/ui/components/github_item.dart';
import 'package:mobile_challenge/app/features/presentation/ui/github_favorites_page.dart';
import 'package:mobile_challenge/app/features/presentation/ui/github_search_page.dart';
import 'package:mocktail/mocktail.dart';

class SearchByTextMock extends Mock implements SearchByText {}

class GetFavoritesUserMock extends Mock implements GetFavoritesUsers {}

class SaveFavoriteUserMock extends Mock implements SaveFavoriteUser {}

class GithubFavoritesPresenterMock extends Mock
    implements GithubFavoritesPresenter {}

class NavigatorObserverMock extends Mock implements NavigatorObserver {}

class RouteMock extends Mock implements Route {}

void main() {
  late SearchByText searchByText;
  late GetFavoritesUsers getFavoritesUsers;
  late SaveFavoriteUser saveFavoriteUser;
  late GithubSearchPresenter presenter;
  late GithubFavoritesPresenter favoritesPresenter;
  late NavigatorObserver navigatorObserver;

  setUpAll(() {
    registerFallbackValue<Route>(RouteMock());
  });

  setUp(() {
    searchByText = SearchByTextMock();
    getFavoritesUsers = GetFavoritesUserMock();
    saveFavoriteUser = SaveFavoriteUserMock();
    presenter = GithubSearchPresenterImpl(searchByText);
    favoritesPresenter = GithubFavoritesPresenterImpl(
      saveFavoriteUser,
      getFavoritesUsers,
    );
    navigatorObserver = NavigatorObserverMock();
    getIt.reset();
    getIt.registerFactory<SearchByText>(() => searchByText);
    getIt.registerFactory<GetFavoritesUsers>(() => getFavoritesUsers);
    getIt.registerFactory<SaveFavoriteUser>(() => saveFavoriteUser);
    getIt.registerFactory<GithubSearchPresenter>(() => presenter);
    getIt.registerFactory<GithubFavoritesPresenter>(() => favoritesPresenter);
  });

  Widget buildWidget(Widget widget) {
    return MaterialApp(
      home: widget,
      navigatorObservers: [navigatorObserver],
    );
  }

  final result = [
    ResultSearchModel(
      username: 'test_1',
      imageUrl: '',
    ),
    ResultSearchModel(
      username: 'teste_2',
      imageUrl: '',
    ),
  ];

  testWidgets('Should find the widgets of the page', (tester) async {
    await tester.pumpWidget(
      buildWidget(GithubSearchPage()),
    );
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets(
      'Should search by text after text field inputted and find two registers',
      (tester) async {
    when(() => searchByText.call(SearchParams(query: 'test'))).thenAnswer(
      (_) async => Right(result),
    );
    await tester.pumpWidget(
      buildWidget(GithubSearchPage()),
    );
    final textField = find.byType(TextFormField);
    await tester.enterText(textField, 'test');
    await tester.pump(Duration(seconds: 1));
    expect(find.byType(GithubItem), findsNWidgets(2));
    verify(() => searchByText(SearchParams(query: 'test'))).called(1);
  });

  testWidgets('Should navigate to favorites page after button tapped',
      (tester) async {
    when(() => getFavoritesUsers(NoParams()))
        .thenAnswer((_) async => Right([]));
    await tester.pumpWidget(
      buildWidget(GithubSearchPage()),
    );
    final button = find.byType(ElevatedButton);
    await tester.tap(button);
    await tester.pumpAndSettle();
    verify(() => navigatorObserver.didPush(any(), any()));
    verify(() => getFavoritesUsers(NoParams())).called(1);
    expect(find.byType(GithubFavoritesPage), findsOneWidget);
  });
}
