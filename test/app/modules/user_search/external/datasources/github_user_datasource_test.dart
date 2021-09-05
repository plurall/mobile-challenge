
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/modules/user_search/external/github_user_datasource.dart';
import 'package:mobile_challenge/app/modules/user_search/utils/github_user_response.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

void main(){
  final dio = DioMock();
  final datasource = GithubUserDatasource(dio);

  test('Must return a UserResultSearchModel', () async {
    when(dio.get(any)).thenAnswer((_)  async => Response(
        data: jsonDecode(githubUserResponse),
        statusCode: 200,
        requestOptions: null));

    final future = datasource.getSearch("fajusto");
    expect(future, completes);
  });

  test("Must return an error if the status code is not 200", () async {
    when(dio.get(any)).thenAnswer((_) async =>
        Response(data: null, statusCode: 401, requestOptions: null));

    final future = datasource.getSearch("fajusto");
    expect(future, throwsA(isA<DataSourceError>()));
  });
}