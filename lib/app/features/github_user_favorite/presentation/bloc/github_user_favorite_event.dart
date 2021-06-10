import 'package:equatable/equatable.dart';

abstract class GithubUserFavoriteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetGithubUsersFavorites extends GithubUserFavoriteEvent {}
