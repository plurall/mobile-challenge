import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/entities/github_user_favorite.dart';

abstract class GithubUserFavoriteState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends GithubUserFavoriteState {}

class Loading extends GithubUserFavoriteState {}

class Loaded extends GithubUserFavoriteState {
  final List<GithubUserFavorite> favorite;

  Loaded({@required this.favorite});

  @override
  List<Object> get props => [favorite];
}

class Error extends GithubUserFavoriteState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
