import 'package:mobile_challenge/data/models/user.dart';
import 'package:mobile_challenge/domain/usecases/search_users/search_users_interface.dart';

class SearchViewModel {
  final SearchUsersUseCaseInterface useCase;

  SearchViewModel(this.useCase);

  List<User> _users = [];
  bool _haveFoundUsers = true;

  getUsers() => [..._users];

  haveFoundUsers() => _haveFoundUsers;

  search(String searchData) async {
    final response = await useCase.call(searchData);
    if (response.isRight()) {
      var users = response.getOrElse(() => []);
      this._users = users;
      if (users.length > 0) {
        this._haveFoundUsers = true;
      } else {
        this._haveFoundUsers = false;
      }
    } else {
      this._users = [];
    }
  }

  clearSearchError() {
    this._haveFoundUsers = true;
  }
}
