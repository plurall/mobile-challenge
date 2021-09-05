import 'package:flutter/foundation.dart';

class UserSearch {
  final int id;
  final String name;
  final String location;
  final String bio;
  final String login;
  final String email;
  final String avatar;

  UserSearch({
    @required this.id,
    @required this.name,
    @required this.location,
    @required this.bio,
    @required this.login,
    @required this.email,
    @required this.avatar
  });
}