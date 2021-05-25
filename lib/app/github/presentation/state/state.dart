import 'package:mobile_challenge/app/github/domain/entities/github_result_search_entitie.dart';
import 'package:mobile_challenge/app/github/domain/errors/errors.dart';

abstract class GitHubState {}

class GitHubSuccess implements GitHubState {
  final List<GitHubResultSearch> list;

  GitHubSuccess(this.list);
}

class GitHubUserSuccess implements GitHubState {
  final GitHubResultSearch user;

  GitHubUserSuccess(this.user);
}

class GitHubStart implements GitHubState {}

class GitHubLoading implements GitHubState {}

class GitHubError implements GitHubState {
  final FailureSearchUser error;

  GitHubError(this.error);
}
