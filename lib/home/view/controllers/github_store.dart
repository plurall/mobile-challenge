import 'package:mobile_challenge/home/data/models/user_model.dart';
import 'package:mobile_challenge/home/domain/entity/user.dart';
import 'package:mobile_challenge/home/domain/usecases/find_all_users.dart';
import 'package:mobile_challenge/home/domain/usecases/find_user_by_id.dart';
import 'package:mobx/mobx.dart';

part 'github_store.g.dart';

class GithubStore = _GithubStore with _$GithubStore;

abstract class _GithubStore with Store {
  final FindAllUsers _findAllUsers;
  final FindUserById _findUserById;
  _GithubStore(this._findAllUsers, this._findUserById);

  @observable
  ObservableFuture<List<User>> findAllRequest =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<User> findByIdRequest = ObservableFuture.value(null);

  @action
  void findAll(String searchQuery) {
    findAllRequest = _findAllUsers.findAll(searchQuery).asObservable();
  }

  @action
  void findById(int id) {
    findByIdRequest = _findUserById.findUserById(id).asObservable();
  }
}
