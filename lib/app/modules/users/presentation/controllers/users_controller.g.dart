// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $UsersController = BindInject(
  (i) => UsersController(i<GetUsersUsecase>(), i<GetSearchUsersUsecase>()),
  isSingleton: true,
  isLazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsersController on _UsersControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_UsersControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$isLoadingBottomAtom =
      Atom(name: '_UsersControllerBase.isLoadingBottom');

  @override
  bool get isLoadingBottom {
    _$isLoadingBottomAtom.reportRead();
    return super.isLoadingBottom;
  }

  @override
  set isLoadingBottom(bool value) {
    _$isLoadingBottomAtom.reportWrite(value, super.isLoadingBottom, () {
      super.isLoadingBottom = value;
    });
  }

  final _$isErrorAtom = Atom(name: '_UsersControllerBase.isError');

  @override
  bool get isError {
    _$isErrorAtom.reportRead();
    return super.isError;
  }

  @override
  set isError(bool value) {
    _$isErrorAtom.reportWrite(value, super.isError, () {
      super.isError = value;
    });
  }

  final _$usersAtom = Atom(name: '_UsersControllerBase.users');

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

  final _$_UsersControllerBaseActionController =
      ActionController(name: '_UsersControllerBase');

  @override
  dynamic changeLoading(dynamic value) {
    final _$actionInfo = _$_UsersControllerBaseActionController.startAction(
        name: '_UsersControllerBase.changeLoading');
    try {
      return super.changeLoading(value);
    } finally {
      _$_UsersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeLoadingBottom(dynamic value) {
    final _$actionInfo = _$_UsersControllerBaseActionController.startAction(
        name: '_UsersControllerBase.changeLoadingBottom');
    try {
      return super.changeLoadingBottom(value);
    } finally {
      _$_UsersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeError(dynamic value) {
    final _$actionInfo = _$_UsersControllerBaseActionController.startAction(
        name: '_UsersControllerBase.changeError');
    try {
      return super.changeError(value);
    } finally {
      _$_UsersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeUsers(List<UserEntity> value) {
    final _$actionInfo = _$_UsersControllerBaseActionController.startAction(
        name: '_UsersControllerBase.changeUsers');
    try {
      return super.changeUsers(value);
    } finally {
      _$_UsersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isLoadingBottom: ${isLoadingBottom},
isError: ${isError},
users: ${users}
    ''';
  }
}
