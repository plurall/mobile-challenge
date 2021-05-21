// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarks_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BookmarksStore on _BookmarksStoreBase, Store {
  final _$bookmarksStatusAtom =
      Atom(name: '_BookmarksStoreBase.bookmarksStatus');

  @override
  BookmarksStatus get bookmarksStatus {
    _$bookmarksStatusAtom.reportRead();
    return super.bookmarksStatus;
  }

  @override
  set bookmarksStatus(BookmarksStatus value) {
    _$bookmarksStatusAtom.reportWrite(value, super.bookmarksStatus, () {
      super.bookmarksStatus = value;
    });
  }

  final _$usersEntityAtom = Atom(name: '_BookmarksStoreBase.usersEntity');

  @override
  UsersEntity get usersEntity {
    _$usersEntityAtom.reportRead();
    return super.usersEntity;
  }

  @override
  set usersEntity(UsersEntity value) {
    _$usersEntityAtom.reportWrite(value, super.usersEntity, () {
      super.usersEntity = value;
    });
  }

  final _$getBookmarkedUsersAsyncAction =
      AsyncAction('_BookmarksStoreBase.getBookmarkedUsers');

  @override
  Future<void> getBookmarkedUsers() {
    return _$getBookmarkedUsersAsyncAction
        .run(() => super.getBookmarkedUsers());
  }

  @override
  String toString() {
    return '''
bookmarksStatus: ${bookmarksStatus},
usersEntity: ${usersEntity}
    ''';
  }
}
