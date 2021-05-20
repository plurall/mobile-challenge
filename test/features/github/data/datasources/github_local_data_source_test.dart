import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/core/errors/exceptions.dart';
import 'package:mobile_challenge/features/github/data/datasources/github_local_data_source.dart';
import 'package:mobile_challenge/features/github/data/models/user_model.dart';
import 'package:matcher/matcher.dart';
import 'package:mobile_challenge/features/github/data/models/users_model.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  GithubLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        GithubLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getCachedUser', () {
    final tUser = UserModel(
      id: 43092867,
      login: 'FabioXimenes',
      name: 'Fábio Ximenes',
      email: 'fabio.ximenes@test.com',
      avatarUrl: 'https://avatars.githubusercontent.com/u/43092867?v=4',
      bio: 'test bio',
      location: 'test location',
    );

    test(
      'should return User with given username from SharedPreferences if is in cache',
      () async {
        // arrange
        final tUsername = 'FabioXimenes';
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('users_cached.json'));
        // act
        final result = await dataSource.getCachedUser(tUsername);
        // assert
        expect(result, tUser);
      },
    );

    test(
      'should return CacheFailure if given username is not in cache',
      () async {
        // arrange
        final usernameNotInCache = 'UsernameNotInCache';
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('users_cached.json'));
        // act
        final call = dataSource.getCachedUser;
        // assert
        expect(() => call(usernameNotInCache),
            throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('getBookmarkedUsers', () {
    final tUsers =
        UsersModel.fromJson(json.decode(fixture('users_cached.json')));

    test(
      'should return users in cache from SharedPreferences if there are users cached',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('users_cached.json'));
        // act
        final result = await dataSource.getBookmarkedUsers();
        // assert
        expect(result, tUsers);
      },
    );

    test(
      'should return CacheException if there is no user in cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSource.getBookmarkedUsers;
        // assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  // group('saveUser', () {
  //   final tUser = UserModel(
  //     id: 43092867,
  //     login: 'FabioXimenes',
  //     name: 'Fábio Ximenes',
  //     email: 'fabio.ximenes@test.com',
  //     avatarUrl: 'https://avatars.githubusercontent.com/u/43092867?v=4',
  //     bio: 'test bio',
  //     location: 'test location',
  //   );

  //   test(
  //     'should call SharedPreferences to cache the user',
  //     () async {
  //       // arrange
        
  //       // act
        
  //       // assert
        
  //     },
  //   );
  // });
}
