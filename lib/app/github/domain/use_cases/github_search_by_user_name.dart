import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/github/domain/entities/github_result_search_entitie.dart';
import 'package:mobile_challenge/app/github/domain/errors/errors.dart';
import 'package:mobile_challenge/app/github/domain/repositories/github_search_repository.dart';

abstract class GitHubSearchByUserName {
  Future<Either<FailureSearchUser, List<GitHubResultSearch>>> call(
      String searchUserName);

  Future<Either<FailureSearchUser, GitHubResultSearch>> user(
      String searchUserName);
}

class GitHubSearchByUserNameImpl implements GitHubSearchByUserName {
  final GithubSearchRepository repository;
  GitHubSearchByUserNameImpl(this.repository);

  @override
  Future<Either<FailureSearchUser, List<GitHubResultSearch>>> call(
      String? searchUserName) async {
    if (searchUserName == null || searchUserName.isEmpty) {
      return Left(InvalidTextError());
    }
    return repository.search(searchUserName);
  }

  @override
  Future<Either<FailureSearchUser, GitHubResultSearch>> user(
      String? searchUserName) async {
    if (searchUserName == null || searchUserName.isEmpty) {
      return Left(InvalidTextError());
    }
    return repository.searchUser(searchUserName);
  }
}
