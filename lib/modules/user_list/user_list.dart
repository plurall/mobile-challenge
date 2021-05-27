import 'package:mobile_challenge/modules/user_list/presentation/user_list_page.dart';

import 'package:http/http.dart' as http;

import 'data/datasources/user_list_remote_data_source.dart';
import 'data/repositories/github_search_api_repository.dart';
import 'domain/usecases/get_default_user_list.dart';
import 'domain/usecases/get_new_page_user_search.dart';
import 'domain/usecases/get_user_search.dart';

class UserList {
  http.Client _client;
  UserListRemoteDataSourceProtocol _remoteDataSource;
  GetUserSearch _searchUseCase;
  GetDefaultUserList _defaultListUseCase;
  GetNewPageUserSearch _newPageUserUseCase;
  GithubSearchApiRepository _repo;

  UserList({
    client,
    remoteDataSource,
    repo,
    searchUseCase,
    defaultListUseCase,
    newPageUserUseCase,
  }) {
    _client = client == null ? http.Client() : client;
    _remoteDataSource = remoteDataSource == null
        ? UserListRemoteDataSource(client: _client)
        : remoteDataSource;
    _repo = repo == null
        ? GithubSearchApiRepository(remoteDataSource: _remoteDataSource)
        : repo;
    _searchUseCase =
        searchUseCase == null ? GetUserSearch(_repo) : searchUseCase;
    _defaultListUseCase = defaultListUseCase == null
        ? GetDefaultUserList(_repo)
        : defaultListUseCase;
    _newPageUserUseCase = newPageUserUseCase == null
        ? GetNewPageUserSearch(_repo)
        : newPageUserUseCase;
  }

  routeToPage() => UserListPage(
        client: _client,
        defaultListUseCase: _defaultListUseCase,
        newPageUserUseCase: _newPageUserUseCase,
        remoteDataSource: _remoteDataSource,
        repo: _repo,
        searchUseCase: _searchUseCase,
      );
}
