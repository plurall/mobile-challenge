import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/models/user_detail_model.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/models/users_favorite_model.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  test('Should convert a json to a UserFavoritesModel with correct values', () async {
    final json = jsonDecode(fixture("user_favorites_list.json"));

    final result = UsersFavoriteModel.fromMap(json);

    expect(result.favorites, isA<List<UserDetailModel>>());
    expect(result.favorites.length, equals(2));
  });
}