import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobile_challenge/core/constants.dart';
import 'package:mobile_challenge/models/search_model.dart';
import 'package:mobile_challenge/repositories/user_repository.dart';

class SearchController extends ChangeNotifier {
  Status status;
  int pageCount = 1;
  PagingController pagingController =
      PagingController<int, User>(firstPageKey: 1);
  SearchModel result;
  String _query;

  Future<void> fetchUser(String query) async {
    try {
      status = Status.fetching;
      notifyListeners();
      _query = query;
      var userRepository = Modular.get<UserRepository>();
      result = await userRepository.searchAUser(query, pageCount);
      status = Status.fetched;
      pagingController.appendPage(result.users, ++pageCount);
      pagingController.addPageRequestListener((pageKey) async {
        await requestMoreUsers();
      });
      notifyListeners();
    } catch (e) {
      result = null;
      print(e);
      status = Status.failure;
      notifyListeners();
    }
  }

  Future<void> requestMoreUsers() async {
    print('Pediu');
    var userRepository = Modular.get<UserRepository>();
    result = await userRepository.searchAUser(_query, ++pageCount);
    pagingController.appendPage(result.users, ++pageCount);
  }
}
