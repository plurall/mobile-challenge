import 'package:mobile_challenge/core/error/failures.dart';
import 'package:mobile_challenge/features/search_user/domain/usecases/search_user_by_text.dart';
import 'package:mobile_challenge/features/search_user/presenter/stores/search_user/search_user_state.dart';
import 'package:mobx/mobx.dart';

part 'search_user_store.g.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class SearchUserStore = _SearchUserStoreBase with _$SearchUserStore;

abstract class _SearchUserStoreBase with Store {
  final SearchUserByTextDatasource searchUserByText;

  _SearchUserStoreBase(this.searchUserByText);

  void makeSearch(String text) async {
    setState(LoadingState());
    var result = await searchUserByText(text);
    result.fold(
      (l) {
        setState(ErrorState(message: _getFailureMessage(l)));
      },
      (r) {
        if (r.isEmpty) {
          setState(EmptyState());
        } else {
          setState(LoadedState(users: r));
        }
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
  SearchUserState state = StartState();

  @action
  setState(SearchUserState value) => state = value;
}
