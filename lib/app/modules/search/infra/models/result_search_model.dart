import 'dart:convert';

import 'package:mobile_challenge/app/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final int id;
  final String login;
  final String avatar;
  final String url;

  ResultSearchModel({this.id, this.login, this.avatar, this.url});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': login,
      'avatar': avatar,
      'url': url,
    };
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return ResultSearchModel(
      id: map['id'],
      login: map['login'],
      avatar: map['avatar_url'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) =>
      ResultSearchModel.fromMap(json.decode(source));
}
