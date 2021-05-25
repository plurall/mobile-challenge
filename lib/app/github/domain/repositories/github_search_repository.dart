import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/github/domain/entities/github_result_search_entitie.dart';
import 'package:mobile_challenge/app/github/domain/errors/errors.dart';

abstract class GithubSearchRepository {
  Future<Either<FailureSearchUser, List<GitHubResultSearch>>> search(
      String? searchUserName);

  Future<Either<FailureSearchUser, GitHubResultSearch>> searchUser(
      String? searchUserName);
}
