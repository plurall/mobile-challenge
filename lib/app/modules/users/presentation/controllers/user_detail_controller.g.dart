// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $UserDetailController = BindInject(
  (i) => UserDetailController(i<GetUserUsecase>(), i<DoFavoriteUserUsecase>(),
      i<RemoveFavoriteUserUsecase>()),
  isSingleton: true,
  isLazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserDetailController on _UserDetailControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_UserDetailControllerBase.isLoading');

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

  final _$isErrorAtom = Atom(name: '_UserDetailControllerBase.isError');

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

  final _$userAtom = Atom(name: '_UserDetailControllerBase.user');

  @override
  UserEntity get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserEntity value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$_UserDetailControllerBaseActionController =
      ActionController(name: '_UserDetailControllerBase');

  @override
  dynamic changeLoading(dynamic value) {
    final _$actionInfo = _$_UserDetailControllerBaseActionController
        .startAction(name: '_UserDetailControllerBase.changeLoading');
    try {
      return super.changeLoading(value);
    } finally {
      _$_UserDetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeError(dynamic value) {
    final _$actionInfo = _$_UserDetailControllerBaseActionController
        .startAction(name: '_UserDetailControllerBase.changeError');
    try {
      return super.changeError(value);
    } finally {
      _$_UserDetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeUser(dynamic value) {
    final _$actionInfo = _$_UserDetailControllerBaseActionController
        .startAction(name: '_UserDetailControllerBase.changeUser');
    try {
      return super.changeUser(value);
    } finally {
      _$_UserDetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isError: ${isError},
user: ${user}
    ''';
  }
}
