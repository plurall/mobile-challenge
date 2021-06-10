import '../../../../core/entities/github_user_favorite.dart';
import '../repositories/github_search_repository.dart';

class SetGithubUserFavorite {
  final GithubUserRepository repository;

  SetGithubUserFavorite(this.repository);

  Future<void> call(GithubUserFavorite githubUserFavorite) async {
    return await repository.getGithubUsersLocal(githubUserFavorite);
  }
}
