// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserSearchController on _UserSearchControllerBase, Store {
  Computed<UserListEntity>? _$userListComputed;

  @override
  UserListEntity get userList =>
      (_$userListComputed ??= Computed<UserListEntity>(() => super.userList,
              name: '_UserSearchControllerBase.userList'))
          .value;
  Computed<UserEntity?>? _$currentUserComputed;

  @override
  UserEntity? get currentUser =>
      (_$currentUserComputed ??= Computed<UserEntity?>(() => super.currentUser,
              name: '_UserSearchControllerBase.currentUser'))
          .value;
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_UserSearchControllerBase.loading'))
      .value;

  final _$_userListAtom = Atom(name: '_UserSearchControllerBase._userList');

  @override
  UserListEntity get _userList {
    _$_userListAtom.reportRead();
    return super._userList;
  }

  @override
  set _userList(UserListEntity value) {
    _$_userListAtom.reportWrite(value, super._userList, () {
      super._userList = value;
    });
  }

  final _$_currentUserAtom =
      Atom(name: '_UserSearchControllerBase._currentUser');

  @override
  UserEntity? get _currentUser {
    _$_currentUserAtom.reportRead();
    return super._currentUser;
  }

  @override
  set _currentUser(UserEntity? value) {
    _$_currentUserAtom.reportWrite(value, super._currentUser, () {
      super._currentUser = value;
    });
  }

  final _$_loadingAtom = Atom(name: '_UserSearchControllerBase._loading');

  @override
  bool get _loading {
    _$_loadingAtom.reportRead();
    return super._loading;
  }

  @override
  set _loading(bool value) {
    _$_loadingAtom.reportWrite(value, super._loading, () {
      super._loading = value;
    });
  }

  final _$userSearchAsyncAction =
      AsyncAction('_UserSearchControllerBase.userSearch');

  @override
  Future<void> userSearch(String userLogin) {
    return _$userSearchAsyncAction.run(() => super.userSearch(userLogin));
  }

  final _$_UserSearchControllerBaseActionController =
      ActionController(name: '_UserSearchControllerBase');

  @override
  dynamic setCurrentUser({UserEntity? userEntity}) {
    final _$actionInfo = _$_UserSearchControllerBaseActionController
        .startAction(name: '_UserSearchControllerBase.setCurrentUser');
    try {
      return super.setCurrentUser(userEntity: userEntity);
    } finally {
      _$_UserSearchControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userList: ${userList},
currentUser: ${currentUser},
loading: ${loading}
    ''';
  }
}
