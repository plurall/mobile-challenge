import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/search/domain/errors/errors.dart';
import 'package:mobile_challenge/app/modules/search/external/datasources/github_datasource.dart';
import 'package:mobile_challenge/app/modules/search/utils/github_response.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();

  final datasource = GithubDatasource(dio);

  test("Must return a ResultSearchModel list", () async {
    when(dio.get(any)).thenAnswer((_) async =>
        Response(
          data: jsonDecode(githubResult), 
          statusCode: 200, 
          requestOptions: null
        )
    );

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
