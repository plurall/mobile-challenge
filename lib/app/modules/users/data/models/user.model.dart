import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';

class UserModel extends UserEntity {
  UserModel({int id, String avatarUrl, String login})
      : super(id: id, avatarUrl: avatarUrl, login: login);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'], avatarUrl: json['avatar_url'], login: json['login']);

  static UserEntity toEntity(UserModel model) {
    return UserEntity(
        avatarUrl: model.avatarUrl, login: model.login, id: model.id);
  }
}
