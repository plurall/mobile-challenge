import 'package:flutter/material.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

@immutable
abstract class UserListState {
  @override
  List<Object> get props => [];
}

class Empty extends UserListState {}

class Loading extends UserListState {}

class Loaded extends UserListState {
  final List<User> users;

  Loaded({@required this.users});

  @override
  List<Object> get props => [users];
}

class Error extends UserListState {
  final IconData icon;
  final String message;

  Error({@required this.message, @required this.icon});

  @override
  List<Object> get props => [message];
}
