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

  factory UserFavoriteModel.fromJson(Map<String,dynamic> json) => UserFavoriteModel(
    login: json["login"], 
    bio: json["bio"], 
    name: json["name"], 
    location: json["location"], 
    email: json["email"], 
    avatarUrl: json["avatar_url"], 
    isFavorite: json["isFavorite"]
  );

  UserFavorite toEntity() => UserFavorite(
    login: login, 
    bio: bio, 
    name: name, 
    location: location, 
    email: email, 
    avatarUrl: avatarUrl, 
    isFavorite: isFavorite
  );
}