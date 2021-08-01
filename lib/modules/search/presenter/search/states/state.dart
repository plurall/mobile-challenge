import 'package:mobile_challenge/modules/search/domain/entities/result_search.dart';
import 'package:mobile_challenge/modules/search/domain/errors/errors.dart';

abstract class SearchState{}

class SearchSucces implements SearchState{
  final List<ResultSearch> list;
  SearchSucces(this.list);
}
class SearchStart implements SearchState{}
class SearchLoading implements SearchState{}
class SearchError implements SearchState{
  final FailureSearch error;
  SearchError(this.error);
}