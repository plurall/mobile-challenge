import 'package:mobile_challenge/features/search_user/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/search_user/domain/usecases/search_user_by_text.dart';
import 'package:mobile_challenge/features/search_user/presenter/states/search_state.dart';
import 'package:mobile_challenge/core/usecase/errors/failures.dart';
import 'package:mobx/mobx.dart';
part 'search_user_store.g.dart';

class SearchUserStore = _SearchUserStoreBase with _$SearchUserStore;

abstract class _SearchUserStoreBase with Store {
  final SearchUserByText searchUserByText;

  _SearchUserStoreBase(this.searchUserByText);

  @action
  Future<SearchState> makeSearch(String text) async {
    var result = await searchUserByText(text);
    return result.fold((l) => ErrorState(l), (r) => SuccessState(r));
  }

  @observable
  String searchText = "";

  @observable
  List<UserEntity> users = [];

  @observable
  ServerFailure error = ServerFailure();
}
