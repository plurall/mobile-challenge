import 'package:flutter/widgets.dart';
import 'package:mobile_challenge/app/interfaces/client_http_interface.dart';
import 'package:mobile_challenge/app/models/user_model.dart';
import 'package:mobile_challenge/app/models/users_model.dart';
import 'package:mobile_challenge/app/repositories/apigithub_repository_interface.dart';

class ApiGithubRepository implements IApiGithub {
  final IClientHttp client;

  ApiGithubRepository(this.client);

  @override
  Future<UserModel> findOne(String login) async {
    var json = await client.get('https://api.github.com/users/${login}');
    UserModel model = UserModel.fromMap(json);
    return model;
  }

  Future<List<UsersModel>> findAll(String login) async {
    if (login != null) {
      var json =
          await client.get('https://api.github.com/search/users?q=${login}');
      return List<UsersModel>.from(
          json["items"].map((e) => UsersModel.fromMap(e)));
    } else {
      var json = await client.get('https://api.github.com/users');
      return List<UsersModel>.from(
          json["items"].map((e) => UsersModel.fromMap(e)));
    }
  }
}
