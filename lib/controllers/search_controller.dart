import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobile_challenge/core/constants.dart';
import 'package:mobile_challenge/models/search_model.dart';
import 'package:mobile_challenge/repositories/user_repository.dart';

class SearchController extends ChangeNotifier {
  Status status = Status.idle;
  int pageCount = 1;
  TextEditingController inputController = TextEditingController();
  PagingController pagingController =
      PagingController<int, User>(firstPageKey: 1);
  SearchModel result;
  String query;

  Future<void> fetchUsers(String query) async {
    try {
      status = Status.fetching;
      this.query = query;
      notifyListeners();
      pagingController = PagingController<int, User>(firstPageKey: 1);
      pageCount = 1;
      notifyListeners();
      var userRepository = Modular.get<UserRepository>();
      result = await userRepository.searchAUser(query, pageCount);
      status = Status.fetched;

      if (result.totalCount < 30) {
        pagingController.appendLastPage(result.users);
      } else {
        pagingController.appendPage(result.users, pageCount);
        pagingController.addPageRequestListener((pageKey) async {
          await requestMoreUsers();
        });
      }

      notifyListeners();
    } catch (e) {
      result = null;
      status = Status.failure;
      notifyListeners();
    }
  }

  Future<void> requestMoreUsers() async {
    try {
      var userRepository = Modular.get<UserRepository>();
      result = await userRepository.searchAUser(query, ++pageCount);

      if (pageCount < 1000 && pageCount < result.totalCount) {
        pagingController.appendPage(result.users, ++pageCount);
      }
    } catch (e) {
      pagingController.error = e.toString();
    }
  }
}
