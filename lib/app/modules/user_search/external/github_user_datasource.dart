import 'package:dio/dio.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/modules/user_search/domain/entities/user.dart';
import 'package:mobile_challenge/app/modules/user_search/infra/datasources/user_search_datasource.dart';
import 'package:mobile_challenge/app/modules/user_search/infra/models/user_result_search_model.dart';

class GithubUserDatasource implements UserSearchDatasource {
  final Dio dio;

  GithubUserDatasource(this.dio);
  
  @override
  Future<UserSearch> getSearch(String searchText) async {
    final response = await dio.get("https://api.github.com/users/$searchText");

    if(response.statusCode == 200){
      final item = response.data;
      final user = UserResultSearchModel(
        id: item["id"],
        name: item["name"],
        location: item["location"],
        bio: item["bio"],
        login: item["login"],
        email: item["email"],
        avatar: item["avatar_url"]
      );

      return user;
    } else {
      throw DataSourceError();
    }
  }
  
}