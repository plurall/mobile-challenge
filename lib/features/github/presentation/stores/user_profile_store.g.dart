// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserProfileStore on _UserProfileStoreBase, Store {
  final _$userStatusAtom = Atom(name: '_UserProfileStoreBase.userStatus');

  @override
  UserStatus get userStatus {
    _$userStatusAtom.reportRead();
    return super.userStatus;
  }

  @override
  set userStatus(UserStatus value) {
    _$userStatusAtom.reportWrite(value, super.userStatus, () {
      super.userStatus = value;
    });
  }

  final _$userEntityAtom = Atom(name: '_UserProfileStoreBase.userEntity');

  @override
  UserEntity get userEntity {
    _$userEntityAtom.reportRead();
    return super.userEntity;
  }

  @override
  set userEntity(UserEntity value) {
    _$userEntityAtom.reportWrite(value, super.userEntity, () {
      super.userEntity = value;
    });
  }

  final _$isSavedAtom = Atom(name: '_UserProfileStoreBase.isSaved');

  @override
  bool get isSaved {
    _$isSavedAtom.reportRead();
    return super.isSaved;
  }

  @override
  set isSaved(bool value) {
    _$isSavedAtom.reportWrite(value, super.isSaved, () {
      super.isSaved = value;
    });
  }

  final _$getUserInfoAsyncAction =
      AsyncAction('_UserProfileStoreBase.getUserInfo');

  @override
  Future<void> getUserInfo(String username) {
    return _$getUserInfoAsyncAction.run(() => super.getUserInfo(username));
  }

  final _$checkIfUserIsSavedAsyncAction =
      AsyncAction('_UserProfileStoreBase.checkIfUserIsSaved');

  @override
  Future<void> checkIfUserIsSaved(String username) {
    return _$checkIfUserIsSavedAsyncAction
        .run(() => super.checkIfUserIsSaved(username));
  }

  final _$removeUserFromBookmarksAsyncAction =
      AsyncAction('_UserProfileStoreBase.removeUserFromBookmarks');

  @override
  Future<void> removeUserFromBookmarks() {
    return _$removeUserFromBookmarksAsyncAction
        .run(() => super.removeUserFromBookmarks());
  }

  final _$saveUserAsyncAction = AsyncAction('_UserProfileStoreBase.saveUser');

  @override
  Future<void> saveUser() {
    return _$saveUserAsyncAction.run(() => super.saveUser());
  }

  @override
  String toString() {
    return '''
userStatus: ${userStatus},
userEntity: ${userEntity},
isSaved: ${isSaved}
    ''';
  }
}
