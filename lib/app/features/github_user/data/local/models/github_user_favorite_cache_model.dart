import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../../core/entities/github_user_favorite.dart';

class GithubUserFavoriteCacheModel extends GithubUserFavorite {
  GithubUserFavoriteCacheModel({
    @required String avatar_url,
    @required String name,
    @required String location,
    @required String bio,
    @required String email,
  }) : super(
          avatar_url: avatar_url,
          bio: bio,
          email: email,
          location: location,
          name: name,
        );

  Map<String, dynamic> toMap() {
    return {
      'avatar_url': avatar_url,
      'name': name,
      'location': location,
      'bio': bio,
      'email': email,
    };
  }

  factory GithubUserFavoriteCacheModel.fromMap(Map<String, dynamic> map) {
    return GithubUserFavoriteCacheModel(
      avatar_url: map['avatar_url'],
      name: map['name'],
      location: map['location'],
      bio: map['bio'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GithubUserFavoriteCacheModel.fromJson(String source) =>
      GithubUserFavoriteCacheModel.fromMap(json.decode(source));
}
