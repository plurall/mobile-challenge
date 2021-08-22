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

  test('Should convert a UserFavoritesModel to a json with correct values', () async {
    final tUserDetailList = [
        UserDetailModel(
          login: "joaoarmando",
          bio: "Olá, Plurall!",
          name: "João Armando",
          location: "Petrópolis - RJ",
          email: "joaoaarmando@hotmail.com",
          avatarUrl: "https://randopictureurl.com"
        ),
        UserDetailModel(
          login: "joaoarmando2",
          bio: "Olá, bem vindo ao meu Github!",
          name: "João Armando",
          location: "Rio de Janeiro - Brasil",
          email: "oi@joaoarmando.com",
          avatarUrl: "https://randopictureurl.com"
        ),
    ];
    final expectedList = UsersFavoriteModel(favorites:  tUserDetailList);

    final result = expectedList.toMap();

    expect(result["favorites"], isA<List<Map<String, dynamic>>>());
    expect(result["favorites"].length, equals(2));
  });
}