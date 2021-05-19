import 'dart:convert';

import 'package:mobile_challenge/core/errors/exceptions.dart';
import 'package:mobile_challenge/features/github/data/models/user_model.dart';
import 'package:mobile_challenge/features/github/data/models/users_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

abstract class GithubRemoteDataSource {
  Future<UsersModel> getUsersWithName(String name);
  Future<UserModel> getUser(String username);
}

class GithubRemoteDataSourceImpl implements GithubRemoteDataSource {
  final http.Client client;

  GithubRemoteDataSourceImpl({@required this.client});

  @override
  Future<UserModel> getUser(String username) async {
    return await _getResponseFromUrl('https://api.github.com/users/$username',
        (json) => UserModel.fromJson(json));
  }

  @override
  Future<UsersModel> getUsersWithName(String name) async {
    return await _getResponseFromUrl(
        'https://api.github.com/search/users?q=$name+in:user',
        (json) => UsersModel.fromJson(json));
  }

  Future<dynamic> _getResponseFromUrl(
      String url, Function(Map<String, dynamic> json) fromJson) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
