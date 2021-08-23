import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/data/models/search_model.dart';
import 'package:mobile_challenge/app/data/models/user_model.dart';

///url base do Github
const baseUrl = 'https://api.github.com';

//nossa classe responsável por encapsular os métodos http
class Provider {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 15000,
      receiveTimeout: 15000,
    ),
  );

  Future<List<SearchModel>> searchUsers({@required String name}) async {
    final response = await dio.get<Map>('/search/users?q=$name');
    return SearchModel.fromJsonList(response.data['items']);
  }

  Future<UserModel> getUser({@required String name}) async {
    final response = await dio.get<Map>('/users/$name');
    return UserModel.fromJson(response.data);
  }
}
