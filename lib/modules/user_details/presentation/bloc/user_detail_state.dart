import 'package:flutter/material.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

@immutable
abstract class UserDetailState {}

class Empty extends UserDetailState {}

class Loading extends UserDetailState {}

class Loaded extends UserDetailState {
  final User user;
  final bool favorite;

  Loaded({@required this.user, @required this.favorite});
}

class Error extends UserDetailState {
  final IconData icon;
  final String message;

  Error({@required this.message, @required this.icon});
}
