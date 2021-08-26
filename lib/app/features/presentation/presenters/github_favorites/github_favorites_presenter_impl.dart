import 'package:injectable/injectable.dart';
import 'package:mobile_challenge/app/features/data/models/user_model.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/get_favorites_users.dart';
import '../../../domain/usecases/save_favorite_user.dart';
import 'github_favorites_presenter.dart';

part 'github_favorites_presenter_impl.g.dart';

@Injectable(as: GithubFavoritesPresenter)
class GithubFavoritesPresenterImpl = _GithubFavoritesPresenterImplBase
    with _$GithubFavoritesPresenterImpl
    implements GithubFavoritesPresenter;

abstract class _GithubFavoritesPresenterImplBase with Store {
  final SaveFavoriteUser _saveFavoriteUser;
  final GetFavoritesUsers _getFavoritesUsers;

  _GithubFavoritesPresenterImplBase(
    this._saveFavoriteUser,
    this._getFavoritesUsers,
  );

  @observable
  bool isFavorite = false;

  @observable
  String? error;

  Future<void> setFavorite(String username) async {
    isFavorite = !isFavorite;
    final result = await _saveFavoriteUser(
      SaveUserParams(user: UserModel(username: username)),
    );
    result.fold((l) => error = l.message, (r) => null);
  }

  @observable
  List<User>? favoritesUsersList;

  Future<void> getFavoritesUsers() async {
    final result = await _getFavoritesUsers(NoParams());
    result.fold((l) => error = l.message, (r) => favoritesUsersList = r);
  }
}
