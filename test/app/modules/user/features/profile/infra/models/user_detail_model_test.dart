import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/models/user_detail_model.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  test('Should convert a json to a UserDetailModel with the correct values', () async {
    final json = jsonDecode(fixture("user_detail_response.json"));

    final result = UserDetailModel.fromJson(json);

    expect(result.login, json["login"]);
    expect(result.avatarUrl, json["avatar_url"]);
    expect(result.name, json["name"]);
    expect(result.bio, json["bio"]);
    expect(result.email, json["email"]);
    expect(result.location, json["location"]);
  });

  test('Should convert a UserDetailModel to a json with the correct values', () async {
    final tUser = UserDetailModel(
      login: "joaoarmando", 
      bio: "Olá, Plurall!", 
      name: "João Armando", 
      location: "Petrópolis - RJ", 
      email: "joaoaarmando@hotmail.com", 
      avatarUrl: "https://randopictureurl.com"
    );

    final result = tUser.toMap();

    expect(result["login"], tUser.login);
    expect(result["bio"], tUser.bio);
    expect(result["name"], tUser.name);
    expect(result["location"], tUser.location);
    expect(result["email"], tUser.email);
    expect(result["avatar_url"], tUser.avatarUrl);
  });
}