// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $UsersController = BindInject(
  (i) => UsersController(i<GetUsersUsecase>()),
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
  String toString() {
    return '''
isLoading: ${isLoading},
isError: ${isError}
    ''';
  }
}
