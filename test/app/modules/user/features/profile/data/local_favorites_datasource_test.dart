import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/data/local_favorites_datasource.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/domain/errors/favorites_errors.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/models/user_detail_model.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/models/users_detail_model.dart';
import 'package:mobile_challenge/app/shared/utils/prefs_key.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';


class SharedPreferencesMock extends Mock implements SharedPreferences {}
void main() {

  late final SharedPreferencesMock prefs;
  late final LocalFavoritesDatasource datasource;
  final tListUsers = 
    UsersDetailModel.fromMap(jsonDecode(fixture("user_detail_list.json"))).users;
  final tUser = UserDetailModel(
    login: "test_user", 
    bio: "bio", 
    name: "name", 
    location: "location", 
    email: "email", 
    avatarUrl: "avatarUrl",
  );

  void _mockListUsersRequest() =>
    when(() => prefs.getString(PrefsKey.CACHED_FAVORITES)).thenAnswer((_) => fixture("user_detail_list.json"));
  

  void _mockPrefsSetStringResponse() =>
   when(() => prefs.setString(any(), any())).thenAnswer((_) async => true);
  

  setUpAll(() {
    prefs = SharedPreferencesMock();
    datasource = LocalFavoritesDatasource(prefs);
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

    test('Should return a list of favorites', () async {
      final result = await datasource.getFavorites();

      expect(result, isA<List<UserDetailModel>>());
      expect(result.length, greaterThan(1));
    });
  });

  group('Verify user favorites', () {
    test('Should return true if user is a favorite', () async {
      final tFavoriteUser = tListUsers[0].toEntity();
      final result = await datasource.verifyFavorite(tFavoriteUser);

      expect(result, equals(true));
    });

    test('Should return false if user is not a favorite', () async {
      final tNotFavoriteUser = tUser.toEntity();
      final result = await datasource.verifyFavorite(tNotFavoriteUser);

      expect(result, equals(false));
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

    test('should throws an exception if user already exist in favorites list', () async {
      final existingUser = tListUsers[0];

      final future = datasource.saveFavorite(existingUser.toEntity());

      expect(future, throwsA(isA<FavoriteAlreadyExists>()));      
    });

  });

  group('Remove Favorites', () {
    test('Should call prefs.setString() with the correct key', () async {     
      await datasource.removeFavorite(tListUsers[0].toEntity());

      verify(() => prefs.setString(PrefsKey.CACHED_FAVORITES, any()));
    });

    test('Should be able remove an existing favorite from a list of favorites', () async {      
      await datasource.removeFavorite(tListUsers[0].toEntity());

      expect(datasource.favorites.length, equals(1));
      expect(datasource.favorites[0].login, tListUsers[1].login);
    });

    test("should throws an exception if the user to be unfavorite doesn't exist in favorites list", () async {
      final future = datasource.removeFavorite(tUser.toEntity());

      expect(future, throwsA(isA<FavoriteDoesntExists>()));      
    });
  });
}