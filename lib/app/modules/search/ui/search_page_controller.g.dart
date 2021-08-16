// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchPageController on _SearchPageControllerBase, Store {
  final _$stateAtom = Atom(name: '_SearchPageControllerBase.state');

  @override
  SearchPageState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(SearchPageState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_searchUsersAsyncAction =
      AsyncAction('_SearchPageControllerBase._searchUsers');

  @override
  Future<Null> _searchUsers(String searchText) {
    return _$_searchUsersAsyncAction.run(() => super._searchUsers(searchText));
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
