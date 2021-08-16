import 'package:mobile_challenge/app/modules/profile/domain/entities/user_detail_entity.dart';

class UserDetailModel {
  final String login;
  final String bio;
  final String name;
  final String avatarUrl;

  UserDetailModel({required this.login, required this.bio, required this.name, required this.avatarUrl});

  factory UserDetailModel.fromJson(Map<String,dynamic> json) => UserDetailModel(
    login: "login",
    bio: "bio",
    name: "name",
    avatarUrl: "avatar_url"
  );

  UserDetailEntity toEntity() => UserDetailEntity(
    login: login, 
    bio: bio, 
    name: name, 
    avatarUrl: avatarUrl
  );
}