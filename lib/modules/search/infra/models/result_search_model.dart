import 'dart:convert';

import 'package:mobile_challenge/modules/search/domain/entities/result_search.dart';



class ResultSearchModel extends ResultSearch {

  final String url;
  final String login;
  final String location;
  final String bio;
  final String name;
  final String email;
  final String image;

  ResultSearchModel({this.url, this.login, this.location, this.bio, this.name, this.email, this.image});

  Map<String, dynamic> toMap(){
    return {
      'url'         : url,
      'login'       : login,
      'location'    : location,
      'bio'         : bio,
      'name'        : name,
      'email'       : email,
      'avatar_url'  : image
    };
  }

  static ResultSearchModel fromMap(Map<String, dynamic> map) {
    if(map == null) return null;

    return ResultSearchModel(
        url       : map['url'],
        login     : map['login'],
        location  : map['location'],
        bio       : map['bio'],
        name      : map['name'],
        email     : map['email'],
        image     : map['avatar_url']
    );
  }

  String toJson() => json.encode(toMap());

  static ResultSearchModel fromJson(String source) => fromMap(json.decode(source));

}