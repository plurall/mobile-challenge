import '../../../domain/entities/user.dart';

abstract class GithubFavoritesPresenter {
  abstract bool isFavorite;
  abstract String? error;
  Future<void> setFavorite(String username);
  abstract List<User>? favoritesUsersList;
  Future<void> getFavoritesUsers();
}
