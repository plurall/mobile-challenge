import 'dart:convert';

import 'package:mobile_challenge/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch{
  final String login;
  final int id;
  final String avatar_url;

  ResultSearchModel({this.login, this.id, this.avatar_url});

  Map<String,dynamic> toMap(){
    return{
      'login':login,
      'id':id,
      'avatar_url':avatar_url,
    };
  }

  static ResultSearchModel fromMap(Map<String,dynamic> map){
    if(map==null) return null;

    return ResultSearchModel(
      login:map['login'],
      id:map['id'],
      avatar_url:map['avatar_url'],
    );
  }

  String toJson() => json.encode(toMap());
  static ResultSearchModel fromJson(String source) => fromMap(json.decode(source));

}