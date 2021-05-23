// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserDetailStore on _UserDetailStoreBase, Store {
  final _$searchTextAtom = Atom(name: '_UserDetailStoreBase.searchText');

  @override
  String get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  final _$stateAtom = Atom(name: '_UserDetailStoreBase.state');

  @override
  UserDetailState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(UserDetailState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_UserDetailStoreBaseActionController =
      ActionController(name: '_UserDetailStoreBase');

  @override
  dynamic setState(UserDetailState value) {
    final _$actionInfo = _$_UserDetailStoreBaseActionController.startAction(
        name: '_UserDetailStoreBase.setState');
    try {
      return super.setState(value);
    } finally {
      _$_UserDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchText: ${searchText},
state: ${state}
    ''';
  }
}
