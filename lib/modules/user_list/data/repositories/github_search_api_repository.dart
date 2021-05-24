import 'package:flutter/material.dart';
import 'package:mobile_challenge/modules/user_list/data/datasources/user_list_remote_data_source.dart';
import 'package:mobile_challenge/modules/user_list/data/models/user_search_model.dart';
import 'package:mobile_challenge/modules/user_list/data/models/user_search_reponse_model.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

abstract class GithubSearchApiRepositoryProtocol {
  Future<UserSearchResponseModel> getDefaultUserList();
  Future<UserSearchResponseModel> getUserSearch(String query);
  Future<UserSearchResponseModel> getNextPageUserSearch(String query, int page);
}

class GithubSearchApiRepository implements GithubSearchApiRepositoryProtocol {
  final UserListRemoteDataSourceProtocol remoteDataSource;

  GithubSearchApiRepository({
    @required this.remoteDataSource,
  });

  @override
  Future<UserSearchResponseModel> getDefaultUserList() async {
    UserSearchApiModel response =
        await remoteDataSource.getSearch('followers:>10000');
    return UserSearchResponseModel(
        response.items, response.items.length < response.totalCount);
  }

  @override
  Future<UserSearchResponseModel> getUserSearch(String query) async {
    UserSearchApiModel response = await remoteDataSource.getSearch(query);
    return UserSearchResponseModel(
        response.items, response.items.length < response.totalCount);
  }

  @override
  Future<UserSearchResponseModel> getNextPageUserSearch(
      String query, int page) async {
    UserSearchApiModel response =
        await remoteDataSource.getSearch(query, page: page);
    return UserSearchResponseModel(
        response.items, response.items.length < response.totalCount);
  }
}
