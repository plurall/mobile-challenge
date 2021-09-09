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
      _users = users;
      if (users.isNotEmpty) {
        _haveFoundUsers = true;
      } else {
        _haveFoundUsers = false;
      }
    } else {
      _users = [];
    }
  }

  clearSearchError() {
    _haveFoundUsers = true;
  }
}
