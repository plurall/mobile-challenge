import 'package:mobile_challenge/app/modules/user_search/domain/entities/user.dart';

class UserResultSearchModel extends UserSearch {
  final int id;
  final String name;
  final String location;
  final String bio;
  final String login;
  final String email;
  final String avatar;

  UserResultSearchModel({
    this.id,
    this.name,
    this.location,
    this.bio,
    this.login,
    this.email,
    this.avatar
  });
}
