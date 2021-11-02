// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserDetailController on _UserDetailControllerBase, Store {
  Computed<UserEntity?>? _$userEntityComputed;

  @override
  UserEntity? get userEntity =>
      (_$userEntityComputed ??= Computed<UserEntity?>(() => super.userEntity,
              name: '_UserDetailControllerBase.userEntity'))
          .value;
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_UserDetailControllerBase.loading'))
      .value;

  final _$_userEntityAtom = Atom(name: '_UserDetailControllerBase._userEntity');

  @override
  UserEntity? get _userEntity {
    _$_userEntityAtom.reportRead();
    return super._userEntity;
  }

  @override
  set _userEntity(UserEntity? value) {
    _$_userEntityAtom.reportWrite(value, super._userEntity, () {
      super._userEntity = value;
    });
  }

  final _$_loadingAtom = Atom(name: '_UserDetailControllerBase._loading');

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

  final _$userDetailAsyncAction =
      AsyncAction('_UserDetailControllerBase.userDetail');

  @override
  Future userDetail(String detailUrl) {
    return _$userDetailAsyncAction.run(() => super.userDetail(detailUrl));
  }

  @override
  String toString() {
    return '''
userEntity: ${userEntity},
loading: ${loading}
    ''';
  }
}
