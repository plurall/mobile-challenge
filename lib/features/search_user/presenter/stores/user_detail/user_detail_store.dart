import 'package:mobile_challenge/core/error/failures.dart';
import 'package:mobile_challenge/features/search_user/domain/usecases/show_detail_user.dart';
import 'package:mobile_challenge/features/search_user/presenter/stores/user_detail/user_detail_state.dart';
import 'package:mobx/mobx.dart';

part 'user_detail_store.g.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class UserDetailStore = _UserDetailStoreBase with _$UserDetailStore;

abstract class _UserDetailStoreBase with Store {
  final ShowDetailUser showDetailUser;

  _UserDetailStoreBase(this.showDetailUser);

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

  @action
  setState(UserDetailState value) => state = value;
}
