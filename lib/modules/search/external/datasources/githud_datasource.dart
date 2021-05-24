import 'package:dio/dio.dart';
import 'package:mobile_challenge/modules/search/domain/errors/errors.dart';
import 'package:mobile_challenge/modules/search/infra/datasources/search_datasouces.dart';
import 'package:mobile_challenge/modules/search/infra/models/result_search_model.dart';

extension on String {
  normaLize(){
    return this.replaceAll(" ", "+");
  }
}

class GitHubDataSource implements SearchDataSource {

  final Dio dio;

  GitHubDataSource(this.dio);

  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {

    final response = await dio.get("https://api.github.com/search/users?q=${searchText.normaLize()}");
    if(response.statusCode == 200){
      final list = (response.data['items'] as List)
          .map((e) => ResultSearchModel.fromMap(e)).toList();

      return list;
    }else{
      throw DataSourceError();
    }

  }

}