

import 'package:mobile_challenge/modules/search/infra/models/result_search_model.dart';

abstract class SearchDataSource {
  Future<List<ResultSearchModel>> getSearch(String searchText);
}