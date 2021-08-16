import 'dart:async';

import 'package:mobx/mobx.dart';

import '../domain/entities/searched_user_entity.dart';
import '../domain/usecases/search_user.dart';

part 'search_page_controller.g.dart';

enum SearchPageState{IDLE,LOADING, NO_INTERNET}

class SearchPageController = _SearchPageControllerBase with _$SearchPageController;

abstract class _SearchPageControllerBase with Store {
  Timer? _searchTypeDelay;

  ObservableList<SearchedUserEntity> searchedUsers = ObservableList();
  late final SearchUser usecase;

  @observable
  SearchPageState state = SearchPageState.IDLE;

  _SearchPageControllerBase(this.usecase);

  void onChangeSearchText(String searchText) {

    if (_searchTypeDelay != null)  _searchTypeDelay!.cancel();

    _searchTypeDelay = Timer(Duration(milliseconds: 500), () => _searchUsers(searchText));    
  }

  Future<Null> _searchUsers(String searchText) async{
    state = SearchPageState.LOADING;
    searchedUsers.clear();

    try {
      final result = await usecase.search(searchText);
      searchedUsers.addAll(result);
    } catch (error) { }

    state = SearchPageState.IDLE;
  }
}