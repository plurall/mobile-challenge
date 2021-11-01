import 'package:mobile_challenge/home/data/models/user_model.dart';
import 'package:mobile_challenge/home/data/service/github_service.dart';
import 'package:mobx/mobx.dart';

part 'github_store.g.dart';

class GithubStore = _GithubStore with _$GithubStore;

abstract class _GithubStore with Store {
  final GithubService _githubService;

  _GithubStore(this._githubService);

  @observable
  ObservableFuture<List<UserModel>> findAllRequest =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<UserModel> findByIdRequest = ObservableFuture.value(null);

  @action
  void findAll(String searchQuery) {
    findAllRequest = _githubService.findAll(searchQuery).asObservable();
  }

  @action
  void findById(int id) {
    findByIdRequest = _githubService.findById(id).asObservable();
  }
}
