import 'dart:convert';

class UserModel {
  int id;
  String login;
  String avatarUrl;
  String url;
  String location;
  String email;
  String bio;
  String createdAt;
  String updatedAt;

  UserModel({
    this.id,
    this.login,
    this.avatarUrl,
    this.url,
    this.location,
    this.email,
    this.bio,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': login,
      'avatarUrl': avatarUrl,
      'url': url,
      'location': location,
      'email': email,
      'bio': bio,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      login: map['login'],
      avatarUrl: map['avatarUrl'],
      url: map['url'],
      location: map['location'],
      email: map['email'],
      bio: map['bio'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
