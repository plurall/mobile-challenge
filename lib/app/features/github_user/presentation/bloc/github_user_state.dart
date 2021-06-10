import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/github_user_details.dart';

abstract class GithubUserDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends GithubUserDetailsState {}

class Loading extends GithubUserDetailsState {}

class Loaded extends GithubUserDetailsState {
  final GithubUserDetails user;

  Loaded({@required this.user});

  @override
  List<Object> get props => [user];
}

class Error extends GithubUserDetailsState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
