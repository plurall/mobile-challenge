import 'package:mobile_challenge/app/features/data/models/result_search_model.dart';

abstract class SearchDatasource {
  Future<List<ResultSearchModel>> fetchSearch(String searchText);
}
