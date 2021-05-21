import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mobile_challenge/model/ResultSearch.dart';
import 'package:mobile_challenge/pages/search_repository.dart';
import 'package:rxdart/subjects.dart';

class SearchPageBlock extends BlocBase {
  final SearchRepository repository;

  SearchPageBlock(this.repository);

  var listUser = BehaviorSubject<ResultSearch>();
  final StreamController<bool> _isLoading$ = StreamController<bool>();
  Sink<bool> get isLoadingIn => _isLoading$.sink;
  Stream<bool> get isLoadingOu => _isLoading$.stream;

  final StreamController<String> _text$ = StreamController<String>();
  Sink<String> get userIn => _text$.sink;
  Stream get userOut => _text$.stream
      .where((text) => text.length > 3)
      .asyncMap((text) => getListUsers(text));

  final StreamController<ResultSearch> _result$ =
      StreamController<ResultSearch>();
  Sink<ResultSearch> get resultIn => _result$.sink;
  Stream get resultOut => _result$.stream;

  getListUsers(String text) async {
    print("PARAMETRO $text");
    try {
      ResultSearch res = await repository.searchText(text);
      resultIn.add(res);
    } catch (e) {
      listUser.addError(e);
    }
  }

  @override
  dispose() {
    _result$.close();
    _isLoading$.close();
    _text$.close();
    super.dispose();
  }
}
