import 'package:dio/dio.dart';
import 'package:mobile_challenge/app/github/data/remote/models/github_result_search_model.dart';
import 'package:mobile_challenge/app/github/domain/errors/errors.dart';

abstract class GitHubSearchDataSource {
  Future<List<GitHubSearchResultModel>> getGitHubUserList(
      String? searchUserName);
  Future<GitHubSearchResultModel> getGitHubUser(String? searchUserName);
}

class GitHubDataSource implements GitHubSearchDataSource {
  final Dio dio;
  GitHubDataSource(this.dio);

  @override
  Future<List<GitHubSearchResultModel>> getGitHubUserList(
      String? searchUserName) async {
    dio.options.baseUrl = 'https://api.github.com';
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;

    final response = await dio.request(
      '/search/users',
      queryParameters: {'q': searchUserName?.replaceAll(' ', '+')},
      options: Options(method: 'GET'),
    );

    if (response.statusCode == 200) {
      final list = (response.data['items'] as List)
          .map((e) => GitHubSearchResultModel.fromMap(e))
          .toList();

      return list;
    } else {
      throw DatasourceError();
    }
  }

  @override
  Future<GitHubSearchResultModel> getGitHubUser(String? searchUserName) async {
    final response = await dio.get(
      'https://api.github.com/users/$searchUserName',
    );

    if (response.statusCode == 200) {
      final user = GitHubSearchResultModel.fromMap(response.data);
      return user;
    } else {
      throw DatasourceError();
    }
  }
}
