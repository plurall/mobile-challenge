import 'package:dartz/dartz.dart';

import '../../../../core/entities/github_user_favorite.dart';
import '../../../../core/error/failures.dart';

abstract class GithubUserFavoriteRepository {
  Future<Either<Failure, List<GithubUserFavorite>>> getGithubUserFavorite();
}
