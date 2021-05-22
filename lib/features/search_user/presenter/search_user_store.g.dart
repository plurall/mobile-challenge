// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchUserStore on _SearchUserStoreBase, Store {
  final _$searchTextAtom = Atom(name: '_SearchUserStoreBase.searchText');

  @override
  String get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  final _$usersAtom = Atom(name: '_SearchUserStoreBase.users');

  @override
  List<UserEntity> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(List<UserEntity> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  final _$_SearchUserStoreBaseActionController =
      ActionController(name: '_SearchUserStoreBase');

  @override
  dynamic setUsers(List<UserEntity> value) {
    final _$actionInfo = _$_SearchUserStoreBaseActionController.startAction(
        name: '_SearchUserStoreBase.setUsers');
    try {
      return super.setUsers(value);
    } finally {
      _$_SearchUserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchText: ${searchText},
users: ${users}
    ''';
  }
}
