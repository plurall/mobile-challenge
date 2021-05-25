import 'dart:convert';

import 'package:mobile_challenge/app/github/domain/entities/github_result_search_entitie.dart';

class GitHubSearchResultModel extends GitHubResultSearch {
  @override
  final int? id;
  @override
  final String? avatar_url;
  @override
  final String? login;
  @override
  final String? name;
  @override
  final String? location;
  @override
  final String? bio;
  @override
  final String? email;

  GitHubSearchResultModel({
    this.id,
    this.avatar_url,
    this.login,
    this.name,
    this.location,
    this.bio,
    this.email,
  });

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

  factory GitHubSearchResultModel.fromMap(Map<String, dynamic> map) {
    return GitHubSearchResultModel(
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

  factory GitHubSearchResultModel.fromJson(String source) =>
      GitHubSearchResultModel.fromMap(json.decode(source));
}
