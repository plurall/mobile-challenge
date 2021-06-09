import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import '../../../../fixtures/fixture.dart';

main() {
  final model = UserModel(id: 11, login: "", avatarUrl: "");
  final entity = UserEntity(id: 11, login: "", avatarUrl: "");

  setUp(() {});

  test('Should model is  entity', () async {
    expect(model is UserEntity, true);
  });

  test('Should do json parse', () async {
    Map<String, dynamic> jsonMap = json.decode(fixture("user.json"));
    final result = UserModel.fromJson(jsonMap);
    expect(model, result);
  });

  test('Should return entity', () async {
    final result = UserModel.toEntity(model);
    expect(result, entity);
  });
}
