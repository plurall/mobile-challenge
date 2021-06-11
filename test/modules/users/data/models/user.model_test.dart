import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import '../../../../fixtures/fixture.dart';

main() {
  final model = UserModel(
      id: 11,
      login: 'user',
      avatarUrl: 'image',
      bio: 'bio',
      email: 'email',
      location: 'location');
  final entity = UserEntity(
      id: 11,
      login: 'user',
      avatarUrl: 'image',
      bio: 'bio',
      email: 'email',
      location: 'location');

  setUp(() {});

  test('Should model is entity', () async {
    expect(model is UserEntity, true);
  });

  test('Should return model when json is given', () async {
    Map<String, dynamic> jsonMap = json.decode(fixture('user.json'));
    final result = UserModel.fromJson(jsonMap);
    expect(model, result);
  });

  test('Should return model when entity is given', () async {
    final result = UserModel.fromEntity(entity);
    expect(result, model);
  });

  test('Should return entity when model is given', () async {
    final result = UserModel.toEntity(model);
    expect(result, entity);
  });

  test('Should return map when model is given', () async {
    final result = UserModel.toMap(model);
    expect(result, {
      'id': 11,
      'login': 'user',
      'location': 'location',
      'bio': 'bio',
      'email': 'email'
    });
  });
}
