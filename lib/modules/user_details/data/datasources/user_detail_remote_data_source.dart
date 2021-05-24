import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_challenge/shared/entities/User.dart';

abstract class UserDetailRemoteDataSourceProtocol {
  Future<User> getUser(String nickname);
}

const BASE_URL = "api.github.com";
const BASE_SUBURL = "/users";
const PER_PAGE = 10;

class UserDetailRemoteDataSource implements UserDetailRemoteDataSourceProtocol {
  final http.Client client;

  UserDetailRemoteDataSource({@required this.client});

  @override
  Future<User> getUser(String nickname) async {
    Uri uri = Uri.https(BASE_URL, BASE_SUBURL + '/$nickname');
    var response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    print(jsonResponse);

    return User.fromJson(jsonResponse);
  }
}
