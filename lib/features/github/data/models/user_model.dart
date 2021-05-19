import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:meta/meta.dart';

class UserModel extends UserEntity {
  final int id;
  final String login;
  final String name;
  final String email;
  final String avatarUrl;
  final String bio;
  final String location;

  UserModel({
    @required this.id,
    @required this.login,
    @required this.name,
    @required this.email,
    @required this.avatarUrl,
    @required this.bio,
    @required this.location,
  }) : super(
          id: id,
          login: login,
          name: name,
          email: email,
          avatarUrl: avatarUrl,
          bio: bio,
          location: location,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      login: json['login'],
      avatarUrl: json['avatar_url'],
      name: json['name'] ?? null,
      email: json['email'] ?? null,
      bio: json['bio'] ?? null,
      location: json['location'] ?? null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "login": login,
      "name": name,
      "email": email,
      "avatar_url": avatarUrl,
      "bio": bio,
      "location": location,
    };
  }
}
