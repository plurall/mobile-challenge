import '../../../domain/entities/result_search.dart';

abstract class GithubSearchPresenter {
  abstract bool isLoading;
  abstract String? error;
  abstract List<ResultSearch>? resultSearchList;
  Future<void> searchUsers(String searchText);
}
