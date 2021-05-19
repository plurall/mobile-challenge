import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/features/github/data/models/user_model.dart';
import 'package:mobile_challenge/features/github/data/models/users_model.dart';
import 'package:mobile_challenge/features/github/domain/entities/users_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tSimplifiedUsersModel = UsersModel(users: [
    UserModel(
      id: 41808,
      login: "fabio",
      avatarUrl: "https://avatars.githubusercontent.com/u/41808?v=4",
      name: null,
      email: null,
      bio: null,
      location: null,
    ),
    UserModel(
      id: 1812093,
      login: "fabiospampinato",
      avatarUrl: "https://avatars.githubusercontent.com/u/1812093?v=4",
      name: null,
      email: null,
      bio: null,
      location: null,
    ),
    UserModel(
      id: 28530,
      login: "fabiomcosta",
      avatarUrl: "https://avatars.githubusercontent.com/u/28530?v=4",
      name: null,
      email: null,
      bio: null,
      location: null,
    ),
  ]);

  final tCompleteUsersModel = UsersModel(users: [
    UserModel(
      id: 41808,
      login: "fabio",
      avatarUrl: "https://avatars.githubusercontent.com/u/41808?v=4",
      name: "test name 1",
      email: "test email 1",
      bio: "test bio 1",
      location: "test location 1",
    ),
    UserModel(
      id: 1812093,
      login: "fabiospampinato",
      avatarUrl: "https://avatars.githubusercontent.com/u/1812093?v=4",
      name: "test name 2",
      email: "test email 2",
      bio: "test bio 2",
      location: "test location 2",
    ),
    UserModel(
      id: 28530,
      login: "fabiomcosta",
      avatarUrl: "https://avatars.githubusercontent.com/u/28530?v=4",
      name: "test name 3",
      email: "test email 3",
      bio: "test bio 3",
      location: "test location 3",
    ),
  ]);

  test('should be a subclass of UsersEntity', () {
    expect(tSimplifiedUsersModel, isA<UsersEntity>());
  });

  group('fromJson', () {
    test(
      'should return the simplified model when the JSON has a list of simplified users',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('get_users_with_name_response.json'));
        // act
        final result = UsersModel.fromJson(jsonMap);
        // assert
        expect(result, tSimplifiedUsersModel);
      },
    );

    test(
      'should return the complete model when the JSON has a list of complete users',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('get_bookmarked_users_response.json'));
        // act
        final result = UsersModel.fromJson(jsonMap);
        // assert
        expect(result, tCompleteUsersModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tCompleteUsersModel.toJson();
        // assert
        final expectJsonMap = {
          "items": [
            {
              "id": 41808,
              "login": "fabio",
              "avatar_url": "https://avatars.githubusercontent.com/u/41808?v=4",
              "name": "test name 1",
              "email": "test email 1",
              "bio": "test bio 1",
              "location": "test location 1",
            },
            {
              "id": 1812093,
              "login": "fabiospampinato",
              "avatar_url":
                  "https://avatars.githubusercontent.com/u/1812093?v=4",
              "name": "test name 2",
              "email": "test email 2",
              "bio": "test bio 2",
              "location": "test location 2",
            },
            {
              "id": 28530,
              "login": "fabiomcosta",
              "avatar_url": "https://avatars.githubusercontent.com/u/28530?v=4",
              "name": "test name 3",
              "email": "test email 3",
              "bio": "test bio 3",
              "location": "test location 3",
            }
          ]
        };
        expect(result, expectJsonMap);
      },
    );
  });
}
