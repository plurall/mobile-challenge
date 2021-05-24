import 'package:flutter/material.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

@immutable
abstract class FavoritesState {
  @override
  List<Object> get props => [];
}

class Empty extends FavoritesState {}

class Loading extends FavoritesState {}

class Loaded extends FavoritesState {
  final List<User> users;

  Loaded({@required this.users});

  @override
  List<Object> get props => [users];
}

class Error extends FavoritesState {
  final IconData icon;
  final String message;

  Error({@required this.message, @required this.icon});

  @override
  List<Object> get props => [message];
}
