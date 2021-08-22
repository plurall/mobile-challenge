import '../../domain/entities/user_entity.dart';

class SearchedUserModel {
  final String login;
  final String avatarUrl;

  SearchedUserModel({required this.login, required this.avatarUrl});

  factory SearchedUserModel.fromMap(Map<String,dynamic> json) {
    return SearchedUserModel(
      login: json["login"],
      avatarUrl: json["avatar_url"]
    );
  }

  UserEntity toEntity() => UserEntity(
    login: login, 
    avatarUrl: avatarUrl
  );
}