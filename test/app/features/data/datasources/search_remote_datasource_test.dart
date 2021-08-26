import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/features/data/datasources/search_remote_datasource.dart';
import 'package:mobile_challenge/app/features/infra/http/rest_client/rest_client.dart';
import 'package:mobile_challenge/app/features/infra/http/rest_client/rest_client_response.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/github_search_response.dart';

class DioRestMock extends Mock implements RestClient {}

void main() {
  final restClient = DioRestMock();
  final datasource = SearchRemoteDatasource(restClient: restClient);
  test('Should return a ResultSearchModel list', () async {
    when(
      () => restClient.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer(
      (_) async => RestClientResponse(
        data: jsonDecode(githubResult),
        statusCode: 200,
      ),
    );
    final future = datasource.fetchSearch('any_text');
    expect(future, completes);
  });

  test('Should return an DatasourceError if the code isnt 200', () async {
    when(
      () => restClient.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer(
      (_) async => RestClientResponse(
        statusCode: 400,
      ),
    );
    final future = datasource.fetchSearch('any_text');
    expect(future, throwsA(isA<DatasourceError>()));
  });

  test('Should return an Exception if occurs an error', () async {
    when(() => restClient.get(any())).thenThrow(Exception());
    final future = datasource.fetchSearch('any_text');
    expect(future, throwsA(isA<Exception>()));
  });
}
