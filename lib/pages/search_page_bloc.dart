import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mobile_challenge/model/result_search.dart';
import 'package:mobile_challenge/pages/search_repository.dart';
import 'package:rxdart/subjects.dart';

class SearchPageBlock extends BlocBase {
  final SearchRepository repository;

  SearchPageBlock(this.repository);

  var listUser = BehaviorSubject<List<Items>>();

  final StreamController<String> _text$ = StreamController<String>();
  Sink<String> get userIn => _text$.sink;
  Stream get userOut => _text$.stream
      .where((text) => text.length > 3)
      .asyncMap((text) => getListUsers(text));

  final StreamController<List<Items>> _result$ =
      StreamController<List<Items>>();
  Sink<List<Items>> get resultIn => listUser.sink;
  Stream get resultOut => listUser.stream;

  void getListUsers(String text) async {
    print("PARAMETRO $text");
    try {
      resultIn.add([]);
      var res = await repository.searchText(text);
      print("PARAMETRO $text");
      resultIn.add(res);
    } catch (e) {
      listUser.addError(e);
    }
  }

  @override
  dispose() {
    _result$.close();
    _text$.close();
    super.dispose();
  }
}
