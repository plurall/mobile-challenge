import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entities/result_search.dart';
import '../../../domain/usecases/search_by_text.dart';
import 'github_search_presenter.dart';

part 'github_search_presenter_impl.g.dart';

@Injectable(as: GithubSearchPresenter)
class GithubSearchPresenterImpl = _GithubSearchPresenterImplBase
    with _$GithubSearchPresenterImpl
    implements GithubSearchPresenter;

abstract class _GithubSearchPresenterImplBase with Store {
  final SearchByText _searchByText;

  _GithubSearchPresenterImplBase(this._searchByText);

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  List<ResultSearch>? resultSearchList;

  Future<void> searchUsers(String searchText) async {
    isLoading = true;
    final result = await _searchByText(SearchParams(query: searchText));
    result.fold((l) {
      error = l.message;
      resultSearchList = [];
    }, (r) => resultSearchList = r);
    isLoading = false;
  }
}
