import 'package:async/async.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localstore/localstore.dart';
import 'package:mobile_challenge/app/modules/user_search/domain/usecases/search_by_user_login.dart';
import 'package:mobile_challenge/app/modules/user_search/infra/models/user_result_search_model.dart';
import 'package:mobile_challenge/app/modules/user_search/presentation/states/state.dart';
import 'package:mobx/mobx.dart';

part 'user_search_store.g.dart';

@Injectable()
class UserSearchStore = _UserSearchStore with _$UserSearchStore;

abstract class _UserSearchStore with Store {
  final SearchByUserLogin searchByUserLogin;
  CancelableOperation cancellableOperation;

  _UserSearchStore(this.searchByUserLogin) {
    reaction((_) => searchUserLogin, (text) async {
      stateReaction(text, cancellableOperation);
    }, delay: 300);
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

  var db = Localstore.instance;

  @action
  getUserStream(){
    userStream = db.collection('users').get().asStream();
  }

  @observable
  Stream userStream;

  @observable
  String searchUserLogin = "";

  @observable
  bool showUserDetails = false;

  @observable
  UserSearchState state = UserSearchStart();

  @observable
  List<UserResultSearchModel> usersFavList = [];
  
  @observable
  bool isFavorite = true;

  @action
  setSearchText(String value) => searchUserLogin = value;

  @action
  setState(UserSearchState value) => state = value;

  @action
  void showDetails() => showUserDetails = !showUserDetails;

  @action
  saveUser(UserResultSearchModel user) async {
    final id = db.collection('users').doc().id;
    db.collection('users').doc(id).set({
      'id' : user.id,
      'name' : user.name,
      'location' : user.location,
      'bio' : user.bio,
      'login' : user.login,
      'email' : user.email,
      'avatar' : user.avatar,
    });
    getLocalUsers();
  }

  @action
  getLocalUsers() async {
    var users = await db.collection('users').get();
    users.forEach((key, value) {
      var item = UserResultSearchModel.fromMap(value);
      usersFavList.add(item);
    });
  }

  @action
  isFavVerification(login) async {

    var users = await db.collection('users').get();
    var list = [];
    users.forEach((key, value) {
      list.add(value['login']);
    });
    isFavorite = list.contains(login);
  }

}