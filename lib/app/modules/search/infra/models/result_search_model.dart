import 'dart:convert';

import 'package:mobile_challenge/app/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final String title;
  final String content;
  final String avatar;

  ResultSearchModel({this.title, this.content, this.avatar});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'avatar': avatar,
    };
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    return ResultSearchModel(
      title: map['title'],
      content: map['content'],
      avatar: map['avatar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) =>
      ResultSearchModel.fromMap(json.decode(source));
}
