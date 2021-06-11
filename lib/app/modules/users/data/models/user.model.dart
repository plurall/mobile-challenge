import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {int id,
      String avatarUrl,
      String login,
      String bio,
      String email,
      String location})
      : super(
            id: id,
            avatarUrl: avatarUrl,
            login: login,
            location: location,
            email: email,
            bio: bio);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      avatarUrl: json['avatar_url'],
      login: json['login'],
      bio: json['bio'],
      email: json['email'],
      location: json['location']);

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
      id: entity.id,
      avatarUrl: entity.avatarUrl,
      login: entity.login,
      bio: entity.bio,
      email: entity.email,
      location: entity.location);

  static UserEntity toEntity(UserModel model) {
    return UserEntity(
        avatarUrl: model.avatarUrl,
        login: model.login,
        id: model.id,
        bio: model.bio,
        email: model.email,
        location: model.location);
  }

  static Map<String, dynamic> toMap(UserModel model) {
    return {
      'id': model.id,
      'login': model.login,
      'location': model.location,
      'bio': model.bio,
      'email': model.email
    };
  }
}
