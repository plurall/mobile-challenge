import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/entities/github_user_favorite.dart';
import '../local/models/github_user_favorite_cache_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/github_user.dart';
import '../../domain/entities/github_user_details.dart';
import '../../domain/repositories/github_search_repository.dart';
import '../local/data_sources/github_user_favorite_local_datasource.dart';
import '../remote/data_sources/github_search_data_source.dart';

class GitHubSearchRepositoryImpl implements GithubUserRepository {
  final GithubUserRemoteDataSourceImpl remoteDataSource;
  final GithubUserLocalDataSourceImpl localDataSource;

  GitHubSearchRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
  });

  @override
  Future<Either<Failure, GithubUserDetails>> getGithubUserDetails(
      String gitHubUserName) async {
    try {
      final remoteGithubUserDetails =
          await remoteDataSource.getGithubUserDetails(gitHubUserName);
      return Right(remoteGithubUserDetails);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<GithubUser>>> getGithubUsers(
      String gitHubUserName) async {
    try {
      final remoteGithubUser =
          await remoteDataSource.getGithubUsers(gitHubUserName);
      return Right(remoteGithubUser);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<void> getGithubUsersLocal(
      GithubUserFavorite githubUserFavorite) async {
    var githubUserFavoriteModel = GithubUserFavoriteCacheModel(
      bio: githubUserFavorite.bio,
      email: githubUserFavorite.email,
      location: githubUserFavorite.location,
      name: githubUserFavorite.name,
      avatar_url: githubUserFavorite.avatar_url,
    );
    return await localDataSource
        .cacheGithubUserFavorite(githubUserFavoriteModel);
  }
}
