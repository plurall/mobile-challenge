import 'package:equatable/equatable.dart';
import '../../../../core/entities/github_user_favorite.dart';

abstract class GithubUserOrUserDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetGitHubUserOrUserDetails extends GithubUserOrUserDetailsEvent {
  final String gitHubUserName;

  GetGitHubUserOrUserDetails(this.gitHubUserName);

  @override
  List<Object> get props => [gitHubUserName];
}

class SetGitHubUserFavorites extends GithubUserOrUserDetailsEvent {
  final GithubUserFavorite githubUserFavorite;

  SetGitHubUserFavorites(this.githubUserFavorite);

  @override
  List<Object> get props => [githubUserFavorite];
}
