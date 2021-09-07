import 'dart:convert';

import 'package:mobile_challenge/app/modules/user_search/domain/entities/user.dart';

class UserResultSearchModel extends UserSearch {
  final int id;
  final String name;
  final String location;
  final String bio;
  final String login;
  final String email;
  final String avatar;

  UserResultSearchModel({
    this.id,
    this.name,
    this.location,
    this.bio,
    this.login,
    this.email,
    this.avatar
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'bio': bio,
      'login': login,
      'email': email,
      'avatar': avatar,
    };
  }

  factory UserResultSearchModel.fromMap(Map<String, dynamic> map) {
    return UserResultSearchModel(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      bio: map['bio'],
      login: map['login'],
      email: map['email'],
      avatar: map['avatar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResultSearchModel.fromJson(String source) => UserResultSearchModel.fromMap(json.decode(source));
}
