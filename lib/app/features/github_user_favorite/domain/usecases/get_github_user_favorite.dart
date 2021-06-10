import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/entities/github_user_favorite.dart';
import '../repositories/github_user_favorite_repository.dart';

class GetGithubUserFavorite
    implements UseCase<List<GithubUserFavorite>, NoParams> {
  final GithubUserFavoriteRepository repository;

  GetGithubUserFavorite(this.repository);
  @override
  Future<Either<Failure, List<GithubUserFavorite>>> call(
      NoParams params) async {
    return await repository.getGithubUserFavorite();
  }
}
