import 'package:mobx/mobx.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/entity/user_entity.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/entity/user_list_entity.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/usecase/user_search_usecase.dart';
part 'user_search_controller.g.dart';

class UserSearchController = _UserSearchControllerBase
    with _$UserSearchController;

abstract class _UserSearchControllerBase with Store {
  final UserSearchUsecase _usecase;

  _UserSearchControllerBase({
    required UserSearchUsecase usecase,
  }) : _usecase = usecase;

  @observable
  UserListEntity _userList = UserListEntity(userListEntity: <UserEntity>[]);

  @computed
  UserListEntity get userList => _userList;

  @observable
  UserEntity? _currentUser;

  @computed
  UserEntity? get currentUser => _currentUser;

  @action
  setCurrentUser({UserEntity? userEntity}) {
    _currentUser = userEntity;
  }

  @observable
  bool _loading = false;

  @computed
  bool get loading => _loading;

  @action
  Future<void> userSearch(String userLogin) async {
    _loading = true;
    final result = await _usecase.userSearch(userLogin);
    result.fold(
      (l) => null,
      (r) => _userList = r,
    );
    _loading = false;
  }
}
