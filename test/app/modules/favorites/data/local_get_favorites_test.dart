import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/favorites/data/local_get_favorites.dart';
import 'package:mobile_challenge/app/modules/favorites/infra/models/user_favorite_model.dart';
import 'package:mobile_challenge/app/modules/favorites/infra/models/users_favorite_model.dart';
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

  void _mockListUsersRequest() =>
    when(() => prefs.getString(PrefsKey.CACHED_FAVORITES)).thenAnswer((_) => fixture("user_favorites_list.json"));
  

  void _mockPrefsSetStringResponse() =>
   when(() => prefs.setString(any(), any())).thenAnswer((_) async => true);
  

  setUpAll(() {
    prefs = SharedPreferencesMock();
    datasource = LocalGetFavorites(prefs);
  });


  setUp(() {
    _mockListUsersRequest();
    _mockPrefsSetStringResponse();    
  });

  group('Get UserFavorites', () {
    test('Should call prefs.getString() with the correct key', () async {
      datasource.getFavorites();

      verify(() => prefs.getString(PrefsKey.CACHED_FAVORITES));
    });

    test('Should return a list of UserFavoritesModel', () async {
      final result = await datasource.getFavorites();

      expect(result, isA<List<UserFavoriteModel>>());
      expect(result.length, greaterThan(1));
      expect(result[0].isFavorite, equals(true));
      expect(result[1].isFavorite, equals(false));
    });
  });

  group('Save Favorites', () {
    test('Should call prefs.setString() with the correct key', () async {     
      await datasource.saveFavorite(tUser.toEntity());

      verify(() => prefs.setString(PrefsKey.CACHED_FAVORITES, any()));
    });

    test('Should be able add a new favorite to a list of favorites', () async {      
      await datasource.saveFavorite(tUser.toEntity());

      expect(datasource.favorites.length, equals(3));
      expect(datasource.favorites[2].login, tUser.login);
    });
  });

  group('Remove Favorites', () {
    test('Should call prefs.setString() with the correct key', () async {
      final tListUsers = UsersFavoriteModel.fromMap(jsonDecode(fixture("user_favorites_list.json"))).favorites;
      
      await datasource.removeFavorite(tListUsers[0].toEntity());

      verify(() => prefs.setString(PrefsKey.CACHED_FAVORITES, any()));
    });

    test('Should be able remove an existing favorite from a list of favorites', () async {
      final tListUsers = UsersFavoriteModel.fromMap(jsonDecode(fixture("user_favorites_list.json"))).favorites; 
      
      await datasource.removeFavorite(tListUsers[0].toEntity());

      expect(datasource.favorites.length, equals(1));
      expect(datasource.favorites[0].login, tListUsers[1].login);
    });
  });
}