import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/modules/search/domain/errors/errors.dart';
import 'package:mobile_challenge/modules/search/external/datasources/githud_datasource.dart';
import 'package:mockito/mockito.dart';

import '../../utils/github_response.dart';


class DioMock extends Mock implements Dio {}

main (){

  final dio = DioMock();

  final datasource = GitHubDataSource(dio);

  test('Deve retornar uma lista de ResultSearchModel', () async {
    when(dio.get(any))
        .thenAnswer((_) async => Response(data: jsonDecode(githubResult), statusCode: 200,requestOptions: null ));

    final future = datasource.getSearch("teste");
    expect(future, completes);
  });

  test('Deve retornar um erro se o codigo não for 200', () async {
    when(dio.get(any))
        .thenAnswer((_) async => Response(data: null, statusCode: 4001, requestOptions: null ));

    final future = datasource.getSearch("teste");
    expect(future, throwsA(isA<DataSourceError>()));
  });

  test('Deve retornar um Exception se tiver um erro no dio', () async {
    when(dio.get(any)).thenThrow(Exception());

    final future = datasource.getSearch("teste");
    expect(future, throwsA(isA<Exception>()));
  });
}
