import 'dart:convert';

import 'package:mobile_challenge/app/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final int id;
  final String title;
  final String avatar;
  final String url;

  ResultSearchModel({this.id, this.title, this.avatar, this.url});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'avatar': avatar,
    };
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return ResultSearchModel(
      id: map['id'],
      title: map['login'],
      avatar: map['avatar_url'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) =>
      ResultSearchModel.fromMap(json.decode(source));
}
