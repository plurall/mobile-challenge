import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/features/data/models/user_model.dart';
import 'package:mobile_challenge/app/features/domain/entities/user.dart';

import '../../../../fixtures/json_reader.dart';

main() {
  final user = UserModel(
    username: 'any_username',
    imageUrl: 'any_image',
  );

  test('Should be a User entity', () {
    expect(user, isA<User>());
  });

  test('Should return a User Model after fromJson factory called', () {
    final decodedJson = json.decode(jsonReader('user.json'));
    final userModel = UserModel.fromJson(decodedJson);
    expect(userModel, isA<User>());
  });

  test('Should return a mapped json from ResultSearchModel', () {
    final result = user.toJson();
    final map = <String, dynamic>{
      'login': user.username,
      'avatar_url': user.imageUrl,
      'location': user.location,
      'bio': user.bio,
      'email': user.email,
    };
    expect(result, map);
  });
}
