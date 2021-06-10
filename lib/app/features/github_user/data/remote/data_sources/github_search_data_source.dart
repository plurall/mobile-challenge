import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../domain/entities/github_user.dart';
import '../../../domain/entities/github_user_details.dart';
import '../models/github_user_details_model.dart';
import '../models/github_user_model.dart';

const _BASE_URL = 'https://api.github.com';

abstract class GithubUserDataSource {
  /// Calls the https://api.github.com/search/users/q endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<GithubUser>> getGithubUsers(String gitHubUserName);

  /// Calls the https://api.github.com/search/users endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<GithubUserDetails> getGithubUserDetails(String gitHubUserName);
}

class GithubUserRemoteDataSourceImpl implements GithubUserDataSource {
  final Dio client;
  GithubUserRemoteDataSourceImpl({@required this.client});

  @override
  Future<GithubUserDetails> getGithubUserDetails(String gitHubUserName) async {
    final response = await client.get(
      '$_BASE_URL/users/$gitHubUserName',
    );

    if (response.statusCode == 200) {
      final user = GithubUserDetailsModel.fromMap(response.data);
      return user;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<GithubUser>> getGithubUsers(String gitHubUserName) async {
    final response = await client.request(
      '$_BASE_URL/search/users',
      queryParameters: {'q': gitHubUserName.replaceAll(' ', '+')},
      options: Options(method: 'GET'),
    );

    if (response.statusCode == 200) {
      return (response.data['items'] as List)
          .map((e) => GithubUserModel.fromMap(e))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
