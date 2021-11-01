import 'package:mobx/mobx.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/entity/user_entity.dart';
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
  List<UserEntity> _userList = <UserEntity>[];

  @computed
  List<UserEntity> get userList => _userList;

  @observable
  bool _loading = false;

  @computed
  bool get loading => _loading;

  @action
  userSearch(String userLogin) async {
    _loading = true;
    final result = await _usecase.userSearch(userLogin);
    result.fold(
      (l) => null,
      (r) => _userList = r,
    );
    _loading = false;
  }
}
