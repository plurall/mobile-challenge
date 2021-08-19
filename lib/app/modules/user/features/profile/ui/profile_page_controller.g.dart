// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfilePageController on _ProfilePageControllerBase, Store {
  final _$userDetailAtom = Atom(name: '_ProfilePageControllerBase.userDetail');

  @override
  UserDetailEntity? get userDetail {
    _$userDetailAtom.reportRead();
    return super.userDetail;
  }

  @override
  set userDetail(UserDetailEntity? value) {
    _$userDetailAtom.reportWrite(value, super.userDetail, () {
      super.userDetail = value;
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

  @override
  String toString() {
    return '''
userDetail: ${userDetail},
state: ${state}
    ''';
  }
}
