import 'package:flutter/material.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

@immutable
abstract class UserDetailState {
  @override
  List<Object> get props => [];
}

class Empty extends UserDetailState {}

class Loading extends UserDetailState {}

class Loaded extends UserDetailState {
  final User user;

  Loaded({@required this.user});

  @override
  List<Object> get props => [user];
}

class Error extends UserDetailState {
  final IconData icon;
  final String message;

  Error({@required this.message, @required this.icon});

  @override
  List<Object> get props => [message];
}
