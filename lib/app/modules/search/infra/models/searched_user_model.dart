import '../../domain/entities/searched_user.dart';

class SearchedUserModel {
  final String id;
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

  SearchedUser toEntity() => SearchedUser(
    id: id, 
    login: login, 
    avatarUrl: avatarUrl
  );
}