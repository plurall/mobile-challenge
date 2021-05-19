import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/features/github/data/models/user_model.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tSimplifiedUserModel = UserModel(
    id: 43092867,
    login: 'FabioXimenes',
    avatarUrl: 'https://avatars.githubusercontent.com/u/43092867?v=4',
    name: null,
    email: null,
    bio: null,
    location: null,
  );

  final tCompleteUserModel = UserModel(
    id: 43092867,
    login: 'FabioXimenes',
    name: 'Fábio Ximenes',
    email: 'fabio.ximenes@test.com',
    avatarUrl: 'https://avatars.githubusercontent.com/u/43092867?v=4',
    bio: 'test bio',
    location: 'test location',
  );

  test('should be a subclass of UserEntity', () {
    expect(tSimplifiedUserModel, isA<UserEntity>());
  });

  group('fromJson', () {
    test(
      'should return a simplified model when the JSON is the simplified version',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('simplified_user.json'));
        // act
        final result = UserModel.fromJson(jsonMap);
        // assert
        expect(result, tSimplifiedUserModel);
      },
    );

    test(
      'should return the complete model when the JSON is the complete version',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('user_response.json'));
        // act
        final result = UserModel.fromJson(jsonMap);
        // assert
        expect(result, tCompleteUserModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tCompleteUserModel.toJson();
        // assert
        final expectedJsonMap = {
          "id": 43092867,
          "login": 'FabioXimenes',
          "name": 'Fábio Ximenes',
          "email": 'fabio.ximenes@test.com',
          "avatar_url": 'https://avatars.githubusercontent.com/u/43092867?v=4',
          "bio": 'test bio',
          "location": 'test location',
        };
        expect(result, expectedJsonMap);
      },
    );

    test(
      'should return a JSON map containing the proper data for the simplified user',
      () async {
        // act
        final result = tSimplifiedUserModel.toJson();
        // assert
        final expectedJsonMap = {
          "id": 43092867,
          "login": 'FabioXimenes',
          "avatar_url": 'https://avatars.githubusercontent.com/u/43092867?v=4',
          "name": null,
          "email": null,
          "bio": null,
          "location": null,
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
