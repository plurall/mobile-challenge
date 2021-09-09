import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/data/models/user.dart';

import '../../fixtures/fixtures.dart';

void main() {
  final user = User(
    avatar: 'https://avatars.githubusercontent.com/u/1655785?v=4',
    bio: 'Front end developer.',
    email: null,
    id: 1655785,
    location: 'São Paulo, Brasil',
    login: 'williambraz',
    name: 'William Braz',
  );

  test('Expect to create user model from json', () async {
    final jsonData = json.decode(fixture('user.json'));
    final result = User.fromJson(jsonData);
    expect(result.id, user.id);
    expect(result.login, user.login);
    expect(result.avatar, user.avatar);
    expect(result.bio, user.bio);
    expect(result.email, user.email);
    expect(result.location, user.location);
  });
}
