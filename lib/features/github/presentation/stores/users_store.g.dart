// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsersStore on _UsersStoreBase, Store {
  final _$statusAtom = Atom(name: '_UsersStoreBase.status');

  @override
  UsersStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(UsersStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$usersAtom = Atom(name: '_UsersStoreBase.users');

  @override
  UsersEntity get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(UsersEntity value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  final _$getUsersWithNameAsyncAction =
      AsyncAction('_UsersStoreBase.getUsersWithName');

  @override
  Future<void> getUsersWithName(String name) {
    return _$getUsersWithNameAsyncAction
        .run(() => super.getUsersWithName(name));
  }

  @override
  String toString() {
    return '''
status: ${status},
users: ${users}
    ''';
  }
}
