import 'dart:async';

import 'package:mobile_challenge/app/core/error/errors.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/search_user.dart';

part 'search_page_controller.g.dart';

enum SearchPageState{IDLE,LOADING, NO_INTERNET}

class SearchPageController = _SearchPageControllerBase with _$SearchPageController;

abstract class _SearchPageControllerBase with Store {
  Timer? _searchTypeDelay;

  ObservableList<UserEntity> searchedUsers = ObservableList();
  late final SearchUser usecase;

  @observable
  SearchPageState state = SearchPageState.IDLE;

  _SearchPageControllerBase(this.usecase);

  void onChangeSearchText(String searchText) {
    if (_searchTypeDelay != null)  _searchTypeDelay!.cancel();

    _searchTypeDelay = Timer(Duration(milliseconds: 500), () => _searchUsers(searchText));    
  }

  @action
  Future<Null> _searchUsers(String searchText) async{
    state = SearchPageState.LOADING;
    searchedUsers.clear();
    
    try {
      final result = await usecase(searchText);
      searchedUsers.addAll(result);
    } on CacheException {
      //Delay gives to the user a feedback that something happens after the types some text
      await Future.delayed(Duration(milliseconds: 300))
        .then((_) => state = SearchPageState.NO_INTERNET);    
      return;
    } catch(exception) {}

    state = SearchPageState.IDLE;
  }
}