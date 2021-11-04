// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoritesStore on _FavoritesStoreBase, Store {
  final _$findAllRequestAtom = Atom(name: '_FavoritesStoreBase.findAllRequest');

  @override
  ObservableFuture<List<User>> get findAllRequest {
    _$findAllRequestAtom.reportRead();
    return super.findAllRequest;
  }

  @override
  set findAllRequest(ObservableFuture<List<User>> value) {
    _$findAllRequestAtom.reportWrite(value, super.findAllRequest, () {
      super.findAllRequest = value;
    });
  }

  final _$deleteRequestAtom = Atom(name: '_FavoritesStoreBase.deleteRequest');

  @override
  ObservableFuture<void> get deleteRequest {
    _$deleteRequestAtom.reportRead();
    return super.deleteRequest;
  }

  @override
  set deleteRequest(ObservableFuture<void> value) {
    _$deleteRequestAtom.reportWrite(value, super.deleteRequest, () {
      super.deleteRequest = value;
    });
  }

  final _$saveRequestAtom = Atom(name: '_FavoritesStoreBase.saveRequest');

  @override
  ObservableFuture<void> get saveRequest {
    _$saveRequestAtom.reportRead();
    return super.saveRequest;
  }

  @override
  set saveRequest(ObservableFuture<void> value) {
    _$saveRequestAtom.reportWrite(value, super.saveRequest, () {
      super.saveRequest = value;
    });
  }

  final _$_FavoritesStoreBaseActionController =
      ActionController(name: '_FavoritesStoreBase');

  @override
  void findAll() {
    final _$actionInfo = _$_FavoritesStoreBaseActionController.startAction(
        name: '_FavoritesStoreBase.findAll');
    try {
      return super.findAll();
    } finally {
      _$_FavoritesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void save( user) {
    final _$actionInfo = _$_FavoritesStoreBaseActionController.startAction(
        name: '_FavoritesStoreBase.save');
    try {
      return super.save(user);
    } finally {
      _$_FavoritesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void delete(User user) {
    final _$actionInfo = _$_FavoritesStoreBaseActionController.startAction(
        name: '_FavoritesStoreBase.delete');
    try {
      return super.delete(user);
    } finally {
      _$_FavoritesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
findAllRequest: ${findAllRequest},
deleteRequest: ${deleteRequest},
saveRequest: ${saveRequest}
    ''';
  }
}
