import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../core/entities/github_user_favorite.dart';

class GithubUserFavoriteModel extends GithubUserFavorite {
  GithubUserFavoriteModel({
    @required String avatar_url,
    @required String name,
    @required String email,
    @required String location,
    @required String bio,
  }) : super(
          name: name,
          email: email,
          location: location,
          bio: bio,
          avatar_url: avatar_url,
        );

  Map<String, dynamic> toMap() {
    return {
      'avatar_url': avatar_url,
      'name': name,
      'email': email,
      'location': location,
      'bio': bio,
    };
  }

  factory GithubUserFavoriteModel.fromMap(Map<String, dynamic> map) {
    return GithubUserFavoriteModel(
      avatar_url: map['avatar_url'],
      name: map['name'],
      email: map['email'],
      location: map['location'],
      bio: map['bio'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GithubUserFavoriteModel.fromJson(String source) =>
      GithubUserFavoriteModel.fromMap(json.decode(source));
}
