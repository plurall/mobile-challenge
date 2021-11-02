import 'package:mobx/mobx.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/entity/user_entity.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/usecase/user_detail_usecase.dart';
part 'user_detail_controller.g.dart';

class UserDetailController = _UserDetailControllerBase
    with _$UserDetailController;

abstract class _UserDetailControllerBase with Store {
  final UserDetailUsecase _usecase;

  _UserDetailControllerBase({
    required UserDetailUsecase usecase,
  }) : _usecase = usecase;

  @observable
  UserEntity? _userEntity;

  @computed
  UserEntity? get userEntity => _userEntity;

  @action
  userDetail(String detailUrl) async {
    final result = await _usecase.userDetail(detailUrl);
    result.fold(
      (l) => null,
      (r) => _userEntity = r,
    );
  }
}
