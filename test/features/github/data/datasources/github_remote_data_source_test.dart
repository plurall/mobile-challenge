import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/core/errors/exceptions.dart';
import 'package:mobile_challenge/features/github/data/datasources/github_remote_data_source.dart';
import 'package:mobile_challenge/features/github/data/models/user_model.dart';
import 'package:mobile_challenge/features/github/data/models/users_model.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  GithubRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = GithubRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getUser', () {
    final tUsername = "FabioXimenes";

    void setUpMockHttpClientSuccess200() {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('user_response.json'), 200));
    }

    void setUpMockHttpClientFailure404() {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('user_response.json'), 404));
    }

    test(
      '''should perform a GET request on a URL being /users/{username}
      the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getUser(tUsername);
        // assert
        verify(mockHttpClient.get(
          Uri.parse('https://api.github.com/users/$tUsername'),
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    final tUserModel =
        UserModel.fromJson(json.decode(fixture('user_response.json')));

    test(
      'should return UserModel when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getUser(tUsername);
        // assert
        expect(result, tUserModel);
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getUser;
        // assert
        expect(() => call(tUsername), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('getUsersWithName', () {
    final tName = 'fabio';

    void setUpMockHttpClientSuccess200() {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async =>
              http.Response(fixture('get_users_with_name_response.json'), 200));
    }

    void setUpMockHttpClientFailure404() {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async =>
              http.Response(fixture('get_users_with_name_response.json'), 404));
    }

    test(
      '''should perform a GET request on a URL being /search/users?q={name}+in:user
      the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getUsersWithName(tName);
        // assert
        verify(mockHttpClient.get(
          Uri.parse('https://api.github.com/search/users?q=$tName+in:user'),
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    final tUsersModel = UsersModel.fromJson(
        json.decode(fixture('get_users_with_name_response.json')));

    test(
      'should return UsersModel when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getUsersWithName(tName);
        // assert
        expect(result, tUsersModel);
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getUsersWithName;
        // assert
        expect(() => call(tName), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
