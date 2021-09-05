import 'package:async/async.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/user_search/domain/usecases/search_by_user_login.dart';
import 'package:mobile_challenge/app/modules/user_search/presentation/states/state.dart';
import 'package:mobx/mobx.dart';

part 'user_search_store.g.dart';

@Injectable()
class UserSearchStore = _UserSearchStore with _$UserSearchStore;

abstract class _UserSearchStore with Store {
  final SearchByUserLogin searchByUserLogin;
  CancelableOperation cancellableOperation;

  _UserSearchStore(this.searchByUserLogin) {
    reaction((_) => searchByUserLogin, (text) async {
      stateReaction(text, cancellableOperation);
    }, delay: 500);
  }

  Future stateReaction(String text,
      [CancelableOperation cancellableOperation]) async {
    await cancellableOperation?.cancel();
    cancellableOperation =
    CancelableOperation<UserSearchState>.fromFuture(makeSearch(text));
    if (text.isEmpty) {
      setState(UserSearchStart());
      return;
    }

    setState(UserSearchLoading());

    setState(await cancellableOperation.valueOrCancellation(UserSearchLoading()));
  }

  Future<UserSearchState> makeSearch(String text) async {
    var result = await searchByUserLogin(text);
    return result.fold((l) => UserSearchError(l), (r) => UserSearchSuccess(r));
  }

  @observable
  String searchUserLogin = "";

  @observable
  UserSearchState state = UserSearchStart();

  @action
  setSearchText(String value) => searchUserLogin = value;

  @action
  setState(UserSearchState value) => state = value;

}