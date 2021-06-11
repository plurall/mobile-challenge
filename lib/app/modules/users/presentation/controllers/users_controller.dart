import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:mobile_challenge/app/modules/users/domain/usecases/get_search_users.usecase.dart';
import 'package:mobile_challenge/app/modules/users/domain/usecases/get_users.usecase.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'users_controller.g.dart';

@Injectable()
class UsersController = _UsersControllerBase with _$UsersController;

abstract class _UsersControllerBase with Store {
  final GetUsersUsecase _usecase;
  final GetSearchUsersUsecase _searchUsecase;
  _UsersControllerBase(this._usecase, this._searchUsecase);

  @observable
  bool isLoading = false;

  @action
  changeLoading(value) => isLoading = value;

  @observable
  bool isLoadingBottom = false;

  @action
  changeLoadingBottom(value) => isLoadingBottom = value;

  @observable
  bool isError = false;

  @action
  changeError(value) => isError = value;

  @observable
  List<UserEntity> users = [];

  @action
  changeUsers(List<UserEntity> value) => users = value;

  bool isSearching = false;
  String searchValue = "";
  int page = 1;

  getUserListForSearch() {
    page = 1;
    if (searchValue == "") {
      isSearching = false;
      getUsers();
    } else {
      isSearching = true;
      getSearchUsers();
    }
  }

  getUserList() async {
    changeError(false);
    if (isSearching) {
      getSearchUsers();
    } else {
      getUsers();
    }
  }

  getUsers() async {
    if (page == 1) {
      changeUsers([]);
      changeError(false);
      changeLoading(true);
    } else {
      changeLoadingBottom(true);
    }
    int lastId = users.length == 0 ? 0 : users.last.id;
    var result = await _usecase(lastId);
    changeLoading(false);
    changeLoadingBottom(false);
    result.fold((error) {
      if (page == 1) {
        changeError(true);
      }
    }, (response) {
      if (page == 1) {
        changeUsers(response);
      } else {
        users.addAll(response);
        changeUsers(users);
      }
      page++;
    });
  }

  getSearchUsers() async {
    if (page == 1) {
      changeError(false);
      changeLoading(true);
    } else {
      changeLoadingBottom(true);
    }
    var result = await _searchUsecase(searchValue, page);
    changeLoading(false);
    changeLoadingBottom(false);
    result.fold((error) {
      if (page == 1) {
        changeError(true);
      }
    }, (response) {
      if (page == 1) {
        changeUsers(response);
      } else {
        users.addAll(response);
        changeUsers(users);
      }
      page++;
    });
  }
}
