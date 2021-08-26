import 'package:injectable/injectable.dart';
import 'package:mobile_challenge/app/features/infra/http/rest_client/rest_client.dart';

import '../../../core/errors/errors.dart';
import '../models/result_search_model.dart';
import 'search_datasource.dart';

@Singleton(as: SearchDatasource)
class SearchRemoteDatasource implements SearchDatasource {
  final RestClient _restClient;

  SearchRemoteDatasource({required RestClient restClient})
      : _restClient = restClient;
  @override
  Future<List<ResultSearchModel>> fetchSearch(String searchText) async {
    final response = await _restClient.get(
      'search/users',
      queryParameters: {
        "q": searchText,
      },
    );
    if (response.statusCode == 200) {
      final result = (response.data['items'] as List)
          .map((item) => ResultSearchModel.fromJson(item))
          .toList();
      return result;
    } else {
      throw DatasourceError();
    }
  }
}
