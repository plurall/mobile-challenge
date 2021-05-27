import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_challenge/clean/exception.dart';
import 'package:mobile_challenge/modules/user_list/data/models/user_search_model.dart';

abstract class UserListRemoteDataSourceProtocol {
  Future<UserSearchApiModel> getSearch(String query, {int page = 1});
}

const BASE_URL = "api.github.com";
const BASE_SUBURL = "/search/users";
const PER_PAGE = 10;

class UserListRemoteDataSource implements UserListRemoteDataSourceProtocol {
  final http.Client client;

  UserListRemoteDataSource({@required this.client});

  @override
  Future<UserSearchApiModel> getSearch(String query, {int page = 1}) async {
    var queryParams = {
      'q': query,
      'per_page': PER_PAGE.toString(),
      'page': page.toString()
    };
    UserSearchApiModel response = await _getSearch(queryParams);
    return response;
  }

  Future<UserSearchApiModel> _getSearch(Map<String, Object> params) async {
    Uri uri;
    try {
      uri = Uri.https(BASE_URL, BASE_SUBURL, params);
    } catch (err) {
      throw ConnectionError();
    }

    var response;

    try {
      response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
    } catch (err) {
      if (err is SocketException) {
        throw ConnectionError();
      } else {
        throw err;
      }
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      try {
        UserSearchApiModel model = UserSearchApiModel.fromJson(jsonResponse);
        return model;
      } catch (err) {
        throw err;
      }
    } else {
      throw ApiError();
    }
  }
}
