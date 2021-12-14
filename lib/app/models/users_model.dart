import 'dart:convert';

class UsersModel {
  String login;
  String avatarUrl;

  UsersModel({
    this.login,
    this.avatarUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'avatarUrl': avatarUrl,
    };
  }

  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      login: map['login'],
      avatarUrl: map['avatarUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UsersModel.fromJson(String source) =>
      UsersModel.fromMap(json.decode(source));
}
