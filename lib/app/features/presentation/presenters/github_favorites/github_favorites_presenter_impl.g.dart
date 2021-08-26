// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_favorites_presenter_impl.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GithubFavoritesPresenterImpl
    on _GithubFavoritesPresenterImplBase, Store {
  final _$isFavoriteAtom =
      Atom(name: '_GithubFavoritesPresenterImplBase.isFavorite');

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

  final _$errorAtom = Atom(name: '_GithubFavoritesPresenterImplBase.error');

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$favoritesUsersListAtom =
      Atom(name: '_GithubFavoritesPresenterImplBase.favoritesUsersList');

  @override
  List<User>? get favoritesUsersList {
    _$favoritesUsersListAtom.reportRead();
    return super.favoritesUsersList;
  }

  @override
  set favoritesUsersList(List<User>? value) {
    _$favoritesUsersListAtom.reportWrite(value, super.favoritesUsersList, () {
      super.favoritesUsersList = value;
    });
  }

  @override
  String toString() {
    return '''
isFavorite: ${isFavorite},
error: ${error},
favoritesUsersList: ${favoritesUsersList}
    ''';
  }
}
