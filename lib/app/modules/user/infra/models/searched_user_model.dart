import '../../domain/entities/user_detail_entity.dart';

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

  UserDetailEntity toEntity() => UserDetailEntity(
    login: login, 
    avatarUrl: avatarUrl
  );
}