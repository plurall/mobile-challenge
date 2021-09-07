// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $UserSearchStore = BindInject(
  (i) => UserSearchStore(i<SearchByUserLogin>()),
  isSingleton: true,
  isLazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserSearchStore on _UserSearchStore, Store {
  final _$userStreamAtom = Atom(name: '_UserSearchStore.userStream');

  @override
  Stream<dynamic> get userStream {
    _$userStreamAtom.reportRead();
    return super.userStream;
  }

  @override
  set userStream(Stream<dynamic> value) {
    _$userStreamAtom.reportWrite(value, super.userStream, () {
      super.userStream = value;
    });
  }

  final _$searchUserLoginAtom = Atom(name: '_UserSearchStore.searchUserLogin');

  @override
  String get searchUserLogin {
    _$searchUserLoginAtom.reportRead();
    return super.searchUserLogin;
  }

  @override
  set searchUserLogin(String value) {
    _$searchUserLoginAtom.reportWrite(value, super.searchUserLogin, () {
      super.searchUserLogin = value;
    });
  }

  final _$showUserDetailsAtom = Atom(name: '_UserSearchStore.showUserDetails');

  @override
  bool get showUserDetails {
    _$showUserDetailsAtom.reportRead();
    return super.showUserDetails;
  }

  @override
  set showUserDetails(bool value) {
    _$showUserDetailsAtom.reportWrite(value, super.showUserDetails, () {
      super.showUserDetails = value;
    });
  }

  final _$stateAtom = Atom(name: '_UserSearchStore.state');

  @override
  UserSearchState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(UserSearchState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$usersFavListAtom = Atom(name: '_UserSearchStore.usersFavList');

  @override
  List<UserResultSearchModel> get usersFavList {
    _$usersFavListAtom.reportRead();
    return super.usersFavList;
  }

  @override
  set usersFavList(List<UserResultSearchModel> value) {
    _$usersFavListAtom.reportWrite(value, super.usersFavList, () {
      super.usersFavList = value;
    });
  }

  final _$isFavoriteAtom = Atom(name: '_UserSearchStore.isFavorite');

  @override
  bool get isFavorite {
    _$isFavoriteAtom.reportRead();
    return super.isFavorite;
  }

  @override
  set isFavorite(bool value) {
    _$isFavoriteAtom.reportWrite(value, super.isFavorite, () {
      super.isFavorite = value;
    });
  }

  final _$isFavUpdateVisibleAtom =
      Atom(name: '_UserSearchStore.isFavUpdateVisible');

  @override
  bool get isFavUpdateVisible {
    _$isFavUpdateVisibleAtom.reportRead();
    return super.isFavUpdateVisible;
  }

  @override
  set isFavUpdateVisible(bool value) {
    _$isFavUpdateVisibleAtom.reportWrite(value, super.isFavUpdateVisible, () {
      super.isFavUpdateVisible = value;
    });
  }

  final _$saveUserAsyncAction = AsyncAction('_UserSearchStore.saveUser');

  @override
  Future saveUser(UserResultSearchModel user) {
    return _$saveUserAsyncAction.run(() => super.saveUser(user));
  }

  final _$getLocalUsersAsyncAction =
      AsyncAction('_UserSearchStore.getLocalUsers');

  @override
  Future getLocalUsers() {
    return _$getLocalUsersAsyncAction.run(() => super.getLocalUsers());
  }

  final _$isFavVerificationAsyncAction =
      AsyncAction('_UserSearchStore.isFavVerification');

  @override
  Future isFavVerification(dynamic login) {
    return _$isFavVerificationAsyncAction
        .run(() => super.isFavVerification(login));
  }

  final _$_UserSearchStoreActionController =
      ActionController(name: '_UserSearchStore');

  @override
  dynamic getUserStream() {
    final _$actionInfo = _$_UserSearchStoreActionController.startAction(
        name: '_UserSearchStore.getUserStream');
    try {
      return super.getUserStream();
    } finally {
      _$_UserSearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchText(String value) {
    final _$actionInfo = _$_UserSearchStoreActionController.startAction(
        name: '_UserSearchStore.setSearchText');
    try {
      return super.setSearchText(value);
    } finally {
      _$_UserSearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setState(UserSearchState value) {
    final _$actionInfo = _$_UserSearchStoreActionController.startAction(
        name: '_UserSearchStore.setState');
    try {
      return super.setState(value);
    } finally {
      _$_UserSearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showDetails() {
    final _$actionInfo = _$_UserSearchStoreActionController.startAction(
        name: '_UserSearchStore.showDetails');
    try {
      return super.showDetails();
    } finally {
      _$_UserSearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateFavList(dynamic value) {
    final _$actionInfo = _$_UserSearchStoreActionController.startAction(
        name: '_UserSearchStore.updateFavList');
    try {
      return super.updateFavList(value);
    } finally {
      _$_UserSearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userStream: ${userStream},
searchUserLogin: ${searchUserLogin},
showUserDetails: ${showUserDetails},
state: ${state},
usersFavList: ${usersFavList},
isFavorite: ${isFavorite},
isFavUpdateVisible: ${isFavUpdateVisible}
    ''';
  }
}
