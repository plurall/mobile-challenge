import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../domain/entities/github_user_details.dart';

class GithubUserDetailsModel extends GithubUserDetails {
  GithubUserDetailsModel({
    @required int id,
    @required String avatar_url,
    @required String login,
    @required String name,
    @required String location,
    @required String bio,
    @required String email,
  }) : super(
          id: id,
          avatar_url: avatar_url,
          bio: bio,
          email: email,
          location: location,
          login: login,
          name: name,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'avatar_url': avatar_url,
      'login': login,
      'name': name,
      'location': location,
      'bio': bio,
      'email': email,
    };
  }

  factory GithubUserDetailsModel.fromMap(Map<String, dynamic> map) {
    return GithubUserDetailsModel(
      id: map['id'],
      avatar_url: map['avatar_url'],
      login: map['login'],
      name: map['name'],
      location: map['location'],
      bio: map['bio'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GithubUserDetailsModel.fromJson(String source) =>
      GithubUserDetailsModel.fromMap(json.decode(source));
}
