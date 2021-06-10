import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../domain/entities/github_user.dart';

class GithubUserModel extends GithubUser {
  GithubUserModel({
    @required int id,
    @required String login,
    @required String avatar_url,
  }) : super(
          id: id,
          login: login,
          avatar_url: avatar_url,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': login,
      'avatar_url': avatar_url,
    };
  }

  factory GithubUserModel.fromMap(Map<String, dynamic> map) {
    return GithubUserModel(
      id: map['id'],
      login: map['login'],
      avatar_url: map['avatar_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GithubUserModel.fromJson(String source) =>
      GithubUserModel.fromMap(json.decode(source));
}
