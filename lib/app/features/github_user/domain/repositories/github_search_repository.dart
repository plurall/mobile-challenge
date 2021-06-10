import 'package:dartz/dartz.dart';
import '../../../../core/entities/github_user_favorite.dart';
import '../../../../core/error/failures.dart';
import '../entities/github_user.dart';
import '../entities/github_user_details.dart';

abstract class GithubUserRepository {
  Future<Either<Failure, List<GithubUser>>> getGithubUsers(
      String gitHubUserName);
  Future<Either<Failure, GithubUserDetails>> getGithubUserDetails(
      String gitHubUserName);
  Future<void> getGithubUsersLocal(GithubUserFavorite githubUserFavorite);
}
