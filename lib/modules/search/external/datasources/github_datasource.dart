import 'package:dio/dio.dart';
import 'package:mobile_challenge/modules/search/domain/errors/errors.dart';
import 'package:mobile_challenge/modules/search/infra/datasources/search_datasource.dart';
import 'package:mobile_challenge/modules/search/infra/models/result_search_model.dart';

extension on String {
  normalize(){
    return this.replaceAll(' ', '+');
  }
}

class GithubDatasource implements SearchDatasource{
  final Dio dio;
  GithubDatasource(this.dio);

  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async{
      final response = await dio.get("https://api.github.com/search/users?q=${searchText.normalize()}");
      if(response.statusCode==200){
        final list =(response.data['items'] as List)
            .map((e) => ResultSearchModel.fromMap(e))
            .toList();
        return list;
      }else{
        throw DatasourceError();
      }
  }
}