import 'package:mobile_challenge/core/error/failures.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_detail_entity.dart';
import 'package:mobile_challenge/features/search_user/domain/usecases/get_all_favorite_local.dart';
import 'package:mobile_challenge/features/search_user/domain/usecases/save_favorite_local.dart';
import 'package:mobile_challenge/features/search_user/domain/usecases/show_detail_user.dart';
import 'package:mobile_challenge/features/search_user/presenter/stores/user_detail/user_detail_state.dart';
import 'package:mobx/mobx.dart';

part 'user_detail_store.g.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class UserDetailStore = _UserDetailStoreBase with _$UserDetailStore;

abstract class _UserDetailStoreBase with Store {
  final ShowDetailUser showDetailUser;
  final SaveFavoriteLocal saveFavoriteLocal;
  final GetAllFavoriteLocal getAllFavoriteLocal;

  _UserDetailStoreBase(
    this.showDetailUser,
    this.saveFavoriteLocal,
    this.getAllFavoriteLocal,
  );

  void showUserDetail(String text) async {
    setState(LoadingState());
    var result = await showDetailUser(text);
    result.fold(
      (l) {
        setState(ErrorState(message: _getFailureMessage(l)));
      },
      (r) {
        setState(LoadedState(user: r));
      },
    );
  }

  void saveFavorite(UserDetailEntity userDetailEntity) async {
    var result = await saveFavoriteLocal(userDetailEntity);

    result.fold(
      (l) {
        setState(ErrorState(message: _getFailureMessage(l)));
      },
      (r) {
        favoriteUser(userDetailEntity);
      },
    );
  }

  void getFavorites() async {
    var result = await getAllFavoriteLocal();

    result.fold(
      (l) {
        setState(ErrorState(message: _getFailureMessage(l)));
      },
      (r) {
        favorites = r;
      },
    );
  }

  String _getFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }

  @observable
  String searchText = "";

  @observable
  UserDetailState state = StartState();

  @observable
  bool isFavorited = false;

  @observable
  List<UserDetailEntity> favorites = [];

  @action
  setState(UserDetailState value) => state = value;

  @action
  favoriteUser(UserDetailEntity userDetailEntity) {
    isFavorited = true;
  }
}
