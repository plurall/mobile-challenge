// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfilePageController on _ProfilePageControllerBase, Store {
  final _$userDetailAtom = Atom(name: '_ProfilePageControllerBase.userDetail');

  @override
  UserEntity? get userDetail {
    _$userDetailAtom.reportRead();
    return super.userDetail;
  }

  @override
  set userDetail(UserEntity? value) {
    _$userDetailAtom.reportWrite(value, super.userDetail, () {
      super.userDetail = value;
    });
  }

  final _$isFavoriteAtom = Atom(name: '_ProfilePageControllerBase.isFavorite');

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

  final _$stateAtom = Atom(name: '_ProfilePageControllerBase.state');

  @override
  ProfilePageState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ProfilePageState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$getUserDetailAsyncAction =
      AsyncAction('_ProfilePageControllerBase.getUserDetail');

  @override
  Future<Null> getUserDetail(String username) {
    return _$getUserDetailAsyncAction.run(() => super.getUserDetail(username));
  }

  final _$saveFavoriteAsyncAction =
      AsyncAction('_ProfilePageControllerBase.saveFavorite');

  @override
  Future<Null> saveFavorite() {
    return _$saveFavoriteAsyncAction.run(() => super.saveFavorite());
  }

  final _$removeFavoriteAsyncAction =
      AsyncAction('_ProfilePageControllerBase.removeFavorite');

  @override
  Future<Null> removeFavorite() {
    return _$removeFavoriteAsyncAction.run(() => super.removeFavorite());
  }

  @override
  String toString() {
    return '''
userDetail: ${userDetail},
isFavorite: ${isFavorite},
state: ${state}
    ''';
  }
}
