// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoritesPageController on _FavoritesPageControllerBase, Store {
  final _$stateAtom = Atom(name: '_FavoritesPageControllerBase.state');

  @override
  FavoritesPageState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(FavoritesPageState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$getFavoritesAsyncAction =
      AsyncAction('_FavoritesPageControllerBase.getFavorites');

  @override
  Future<Null> getFavorites() {
    return _$getFavoritesAsyncAction.run(() => super.getFavorites());
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
