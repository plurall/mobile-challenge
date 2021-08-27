import 'package:mobile_challenge/data/models/user.dart';
import 'package:mobile_challenge/data/remote/search_remote.dart';

class SearchViewModel {
  final searchRemote = SearchRemote();

  List<User> _users = [];
  bool _haveFoundUsers = true;

  getUsers() => [..._users];

  haveFoundUsers() => _haveFoundUsers;

  search(String searchData) async {
    final response = await searchRemote.getUsers(searchData);
    this._users = response;
    if (response.length > 0) {
      this._haveFoundUsers = true;
    } else {
      this._haveFoundUsers = false;
    }
  }

  clearSearchError() {
    this._haveFoundUsers = true;
  }
}
