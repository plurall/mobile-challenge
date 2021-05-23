import 'package:mobile_challenge/core/errors/error.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/search_user/domain/usecases/search_user_by_text.dart';
import 'package:mobx/mobx.dart';
part 'search_user_store.g.dart';

class SearchUserStore = _SearchUserStoreBase with _$SearchUserStore;

abstract class _SearchUserStoreBase with Store {
  final SearchUserByText searchUserByText;

  _SearchUserStoreBase(this.searchUserByText);

  void makeSearch(String text) async {
    setIsLoading(true);
    var result = await searchUserByText(text);
    result.fold(
      (l) {
        setError(l);
      },
      (r) {
        setUsers(r);
      },
    );
    setIsLoading(false);
  }

  @observable
  String searchText = "";

  @observable
  List<UserEntity> users = [];

  @observable
  Failure error = Failure();

  @observable
  bool isLoading = false;

  @action
  setUsers(List<UserEntity> value) => users = value;

  @action
  setError(Failure value) => error = value;

  @action
  setIsLoading(bool value) => isLoading = value;
}
