import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/github_user.dart';

abstract class GithubUsersListState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends GithubUsersListState {}

class Loading extends GithubUsersListState {}

class Loaded extends GithubUsersListState {
  final List<GithubUser> users;

  Loaded({@required this.users});

  @override
  List<Object> get props => [users];
}

class Error extends GithubUsersListState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
