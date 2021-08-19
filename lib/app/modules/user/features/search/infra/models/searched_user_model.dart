import '../../domain/entities/searched_user_entity.dart';

class SearchedUserModel {
  final int id;
  final String login;
  final String avatarUrl;

  SearchedUserModel({required this.id, required this.login, required this.avatarUrl});

  factory SearchedUserModel.fromMap(Map<String,dynamic> json) {
    return SearchedUserModel(
      id: json["id"], 
      login: json["login"],
      avatarUrl: json["avatar_url"]
    );
  }

  SearchedUserEntity toEntity() => SearchedUserEntity(
    id: id.toString(), 
    login: login, 
    avatarUrl: avatarUrl
  );
}