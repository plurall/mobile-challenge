import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/favorites/data/local_get_favorites.dart';
import 'package:mobile_challenge/app/modules/favorites/infra/models/user_favorite_model.dart';
import 'package:mobile_challenge/app/shared/utils/prefs_key.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fixtures/fixture_reader.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}
void main() {
  late final SharedPreferencesMock prefs;
  late final LocalGetFavorites datasource;
  final tUser = UserFavoriteModel(
    login: "test_user", 
    bio: "bio", 
    name: "name", 
    location: "location", 
    email: "email", 
    avatarUrl: "avatarUrl", 
    isFavorite: true,
  );

  setUpAll(() {
    prefs = SharedPreferencesMock();
    datasource = LocalGetFavorites(prefs);
  });

  void _mockListUsersRequest() {
    when(() => prefs.getString(PrefsKey.CACHED_FAVORITES)).thenAnswer((_) => fixture("user_favorites_list.json"));
  }

  group('Get UserFavorites', () {
    test('Should call prefs.getString() with the correct key', () async {
      _mockListUsersRequest();

      datasource.getFavorites();

      verify(() => prefs.getString(PrefsKey.CACHED_FAVORITES));
    });

    test('Should return a list of UserFavoritesModel', () async {
      _mockListUsersRequest();

      final result = await datasource.getFavorites();

      expect(result, isA<List<UserFavoriteModel>>());
      expect(result.length, greaterThan(1));
      expect(result[0].isFavorite, equals(true));
      expect(result[1].isFavorite, equals(false));
    });
  });

  group('Save Favorites', () {
    test('Should call prefs.setString() with the correct key', () async {
      when(() => prefs.setString(any(), any())).thenAnswer((_) async => true);
      
      await datasource.saveFavorites(tUser.toEntity());

      verify(() => prefs.setString(PrefsKey.CACHED_FAVORITES, any()));
    });

    test('Should be able add a new favorite to a list of favories', () async {
      _mockListUsersRequest();
      when(() => prefs.setString(any(), any())).thenAnswer((_) async => true);
      
      await datasource.saveFavorites(tUser.toEntity());

      expect(datasource.favorites.length, equals(3));
      expect(datasource.favorites[2].login, tUser.login);
    });
  });
}