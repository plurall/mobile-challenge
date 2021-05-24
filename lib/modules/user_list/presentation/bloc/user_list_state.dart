import 'package:flutter/material.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

@immutable
abstract class UserListState {}

class Empty extends UserListState {}

class Loading extends UserListState {}

class Loaded extends UserListState {
  final List<User> users;
  final bool hasMore;

  Loaded({@required this.users, @required this.hasMore});
}

class Error extends UserListState {
  final IconData icon;
  final String message;

  Error({@required this.message, this.icon});
}
