import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/features/data/datasources/users_remote_datasource.dart';
import 'package:mobile_challenge/app/features/domain/entities/user.dart';
import 'package:mobile_challenge/app/features/infra/http/rest_client/rest_client.dart';
import 'package:mobile_challenge/app/features/infra/http/rest_client/rest_client_response.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/github_user_response.dart';

class DioRestMock extends Mock implements RestClient {}

void main() {
  final restClient = DioRestMock();
  final datasource = UsersRemoteDatasource(restClient: restClient);
  test('Should return a UserModel if succeeds', () async {
    when(
      () => restClient.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer(
      (_) async => RestClientResponse(
        data: jsonDecode(githubUserResponse),
        statusCode: 200,
      ),
    );
    final result = await datasource.getUser('AlexOliveira123');
    expect(result, isA<User>());
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
        statusCode: 500,
      ),
    );
    final future = datasource.getUser('AlexOliveira123');
    expect(future, throwsA(isA<DatasourceError>()));
  });
}
