import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/entities/github_user_favorite.dart';
import '../../domain/repositories/github_user_favorite_repository.dart';
import '../datasources/github_user_favorite_local_data_source.dart';

class GithubUserFavoriteRepositoryImpl implements GithubUserFavoriteRepository {
  final GithubUserFavotireLocalDataSource localDataSource;

  GithubUserFavoriteRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<GithubUserFavorite>>>
      getGithubUserFavorite() async {
    try {
      final localGithubUserFavorite =
          await localDataSource.getGithubUserFavorites();
      return Right(localGithubUserFavorite);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
