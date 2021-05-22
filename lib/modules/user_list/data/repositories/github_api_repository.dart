import 'package:flutter/material.dart';
import 'package:mobile_challenge/modules/user_list/data/datasources/user_list_local_data_source.dart';
import 'package:mobile_challenge/modules/user_list/data/datasources/user_list_remote_data_source.dart';
import 'package:mobile_challenge/modules/user_list/data/models/user_search_model.dart';
import 'package:mobile_challenge/modules/user_list/domain/entities/User.dart';

abstract class GithubApiRepositoryProtocol {
  Future<List<User>> getDefaultUserList();
  Future<List<User>> getUserSearch(String query);
}

class GithubApiRepository implements GithubApiRepositoryProtocol {
  final UserListRemoteDataSourceProtocol remoteDataSource;
  final UserListLocalDataSourceProtocol localDataSource;

  GithubApiRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
  });

  @override
  Future<List<User>> getDefaultUserList() async {
    UserSearchModel response =
        await remoteDataSource.getSearch('followers:>10000');
    return response.items;
  }

  @override
  Future<List<User>> getUserSearch(String query) async {
    UserSearchModel response = await remoteDataSource.getSearch(query);
    return response.items;
  }
}
