import 'package:dio/dio.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/modules/search/infra/datasources/search_datasource.dart';
import 'package:mobile_challenge/app/modules/search/infra/models/result_search_model.dart';

extension on String {
  format() {
    return this.replaceAll(" ", "+");
  }
}

class GithubDatasource implements SearchDatasource {
  final Dio dio;

  GithubDatasource(this.dio);

  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {
    final response = await dio
        .get("https://api.github.com/search/users?q=${searchText.format()}");


    if (response.statusCode == 200) {
      final jsonList = response.data['items'] as List;
      final list = jsonList
          .map((item) => ResultSearchModel(
          id: item['id'],
          title: item['login'],
          avatar: item['avatar_url'],
          url: item['url']))
          .toList();

      return list;
    } else {
      throw DataSourceError();
    }
  }
}
