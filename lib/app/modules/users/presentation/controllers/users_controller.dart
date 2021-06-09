import 'package:mobile_challenge/app/modules/users/domain/usecases/get_users.usecase.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'users_controller.g.dart';

@Injectable()
class UsersController = _UsersControllerBase with _$UsersController;

abstract class _UsersControllerBase with Store {
  final GetUsersUsecase _usecase;
  _UsersControllerBase(this._usecase);

  @observable
  bool isLoading = false;

  @action
  changeLoading(value) => isLoading = value;

  @observable
  bool isError = false;

  @action
  changeError(value) => isError = value;

  getUsers() async {
    var result = await _usecase("mob");
    result.fold((l) => null, (r) => null);
  }
}
