// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_search_presenter_impl.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GithubSearchPresenterImpl on _GithubSearchPresenterImplBase, Store {
  final _$isLoadingAtom =
      Atom(name: '_GithubSearchPresenterImplBase.isLoading');

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

  final _$errorAtom = Atom(name: '_GithubSearchPresenterImplBase.error');

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

  final _$resultSearchListAtom =
      Atom(name: '_GithubSearchPresenterImplBase.resultSearchList');

  @override
  List<ResultSearch>? get resultSearchList {
    _$resultSearchListAtom.reportRead();
    return super.resultSearchList;
  }

  @override
  set resultSearchList(List<ResultSearch>? value) {
    _$resultSearchListAtom.reportWrite(value, super.resultSearchList, () {
      super.resultSearchList = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
error: ${error},
resultSearchList: ${resultSearchList}
    ''';
  }
}
