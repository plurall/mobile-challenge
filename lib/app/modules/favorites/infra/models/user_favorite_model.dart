import 'dart:convert';

import 'package:mobile_challenge/app/modules/favorites/domain/entities/user_favorite.dart';

class UserFavoriteModel {
  final String login;
  final String? bio;
  final String? name;
  final String? location;
  final String? email;
  final String avatarUrl;
  final bool isFavorite;

  UserFavoriteModel({required this.login, required this.bio, required this.name, 
  required this.location, required this.email, required this.avatarUrl,  required this.isFavorite});

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'bio': bio,
      'name': name,
      'location': location,
      'email': email,
      'avatarUrl': avatarUrl,
      'isFavorite': isFavorite,
    };
  }

  factory UserFavoriteModel.fromMap(Map<String, dynamic> map) {
    return UserFavoriteModel(
      login: map['login'],
      bio: map['bio'],
      name: map['name'],
      location: map['location'],
      email: map['email'],
      avatarUrl: map['avatar_url'],
      isFavorite: map['isFavorite'],
    );
  }

  factory UserFavoriteModel.fromEntity(UserFavorite entity) => UserFavoriteModel(
    login: entity.login,
    bio: entity.bio,
    name: entity.name,
    location: entity.location,
    email: entity.email,
    avatarUrl: entity.avatarUrl,
    isFavorite: entity.isFavorite,
  );

  UserFavorite toEntity() => UserFavorite(
    login: login,
    bio: bio,
    name: name,
    location: location,
    email: email,
    avatarUrl: avatarUrl,
    isFavorite: isFavorite,
  );
}
