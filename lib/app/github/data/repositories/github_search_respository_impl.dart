import 'package:mobile_challenge/app/github/data/remote/data_sources/github_search_data_source.dart';
import 'package:mobile_challenge/app/github/domain/errors/errors.dart';
import 'package:mobile_challenge/app/github/domain/entities/github_result_search_entitie.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/github/domain/repositories/github_search_repository.dart';

class GitHubSearchRepositoryImpl implements GithubSearchRepository {
  final GitHubSearchDataSource dataSource;

  GitHubSearchRepositoryImpl(this.dataSource);
  @override
  Future<Either<FailureSearchUser, List<GitHubResultSearch>>> search(
      String? searchUserName) async {
    try {
      final result = await dataSource.getGitHubUserList(searchUserName);
      return Right(result);
    } catch (e) {
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<FailureSearchUser, GitHubResultSearch>> searchUser(
      String? searchUserName) async {
    try {
      final result = await dataSource.getGitHubUser(searchUserName);
      return Right(result);
    } catch (e) {
      return Left(DatasourceError());
    }
  }
}
