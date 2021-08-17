import 'package:mobile_challenge/app/modules/favorites/domain/entities/user_favorite.dart';

class UserFavoriteModel {
  final String login;
  final String? bio;
  final String? name;
  final String? location;
  final String? email;
  final String avatarUrl;
  final bool isFavorite;

  UserFavoriteModel({required this.login, this.bio, this.name,
  this.location, this.email, required this.avatarUrl,  required this.isFavorite});

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