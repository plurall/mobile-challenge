import 'dart:typed_data';

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/clean/exception.dart';
import 'package:mobile_challenge/modules/user_details/data/datasources/user_detail_remote_data_source.dart';
import 'package:mobile_challenge/modules/user_list/data/datasources/user_list_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_challenge/modules/user_list/data/models/user_search_model.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

import 'remote_db_data.dart';

class _mochClient implements http.Client {
  @override
  void close() {}
  @override
  Future<http.Response> delete(Uri url,
      {Map<String, String> headers, Object body, Encoding encoding}) {}
  @override
  Future<http.Response> head(Uri url, {Map<String, String> headers}) {}
  @override
  Future<http.Response> patch(Uri url,
      {Map<String, String> headers, Object body, Encoding encoding}) {}
  @override
  Future<http.Response> post(Uri url,
      {Map<String, String> headers, Object body, Encoding encoding}) {}
  @override
  Future<http.Response> put(Uri url,
      {Map<String, String> headers, Object body, Encoding encoding}) {}
  @override
  Future<String> read(Uri url, {Map<String, String> headers}) {}
  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String> headers}) {}
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {}

  @override
  Future<http.Response> get(Uri url, {Map<String, String> headers}) async {
    print(url);
    if (url ==
        Uri.parse(
            'https://api.github.com/search/users?q=followers%3A%3E10000&per_page=10&page=1')) {
      return new http.Response(jsonEncode(defaultResponse), 200);
    }
    if (url ==
        Uri.parse(
            'https://api.github.com/search/users?q=maxiin&per_page=10&page=1')) {
      return new http.Response(jsonEncode(usersResponse), 200);
    }
    if (url ==
        Uri.parse(
            'https://api.github.com/search/users?q=EmptyResultSearch&per_page=10&page=1')) {
      return new http.Response(jsonEncode(emptyResponse), 200);
    }
    if (url ==
        Uri.parse('https://api.github.com/search/users?q&per_page=10&page=1')) {
      return new http.Response(jsonEncode(responseMissing), 422);
    }

    if (url == Uri.parse('https://api.github.com/users/maxiin')) {
      return new http.Response(jsonEncode(responseUser), 200);
    }
    if (url == Uri.parse('https://api.github.com/users/nonExistingUser')) {
      return new http.Response(jsonEncode(responseUserNotFound), 404);
    }
  }
}

String expTest() {
  throw ApiError();
}

main() {
  test('Searchs for a specific User', () async {
    UserListRemoteDataSource dataSource =
        UserListRemoteDataSource(client: _mochClient());

    UserSearchApiModel response = await dataSource.getSearch('maxiin');

    expect(response.totalCount, greaterThan(1));
    expect(response.items.length, greaterThan(1));
    expect(response.items[0].runtimeType, User);
  });
  test('Gets initial user list', () async {
    UserListRemoteDataSourceProtocol dataSource =
        UserListRemoteDataSource(client: _mochClient());

    UserSearchApiModel response =
        await dataSource.getSearch('followers:>10000');

    expect(response.totalCount, greaterThan(1));
    expect(response.items.length, greaterThan(1));
    expect(response.items[0].runtimeType, User);
  });
  test('Throws Api Error when search is empt y', () async {
    UserListRemoteDataSourceProtocol dataSource =
        UserListRemoteDataSource(client: _mochClient());

    Exception error;
    UserSearchApiModel response;

    try {
      response = await dataSource.getSearch('');
    } catch (err) {
      error = err;
    }

    expect(error, isException);
    expect(error, isInstanceOf<ApiError>(),
        reason:
            "Will return ApiError when query in the api is empty, returns 422 on the api instead of 200");
    expect(response, isNull);
  });
  test('Gets empty list when searching for a non-existing user', () async {
    UserListRemoteDataSourceProtocol dataSource =
        UserListRemoteDataSource(client: _mochClient());

    UserSearchApiModel response =
        await dataSource.getSearch('EmptyResultSearch');

    expect(response.totalCount, equals(0));
    expect(response.items.length, equals(0));
  });

  test('Gets user details from api', () async {
    UserDetailRemoteDataSource dataSource =
        UserDetailRemoteDataSource(client: _mochClient());

    User response = await dataSource.getUser('maxiin');

    expect(response, isNotNull);
    expect(response, isInstanceOf<User>());
  });
  test('Gets empty for a non-existing user', () async {
    UserDetailRemoteDataSource dataSource =
        UserDetailRemoteDataSource(client: _mochClient());

    User response;
    Exception error;

    try {
      response = await dataSource.getUser('nonExistingUser');
    } catch (err) {
      error = err;
    }

    expect(error, isException);
    expect(error, isInstanceOf<UserNotFoundError>());
    expect(response, isNull);
  });
}
