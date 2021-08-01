import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/modules/search/domain/errors/errors.dart';
import 'package:mobile_challenge/modules/search/external/datasources/github_datasource.dart';
import 'package:mockito/mockito.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio{}

main(){

  final dio = DioMock();
  final datasource = GithubDatasource(dio);
  test('deve retornar uma lista de ResultModel', () async{
      when(dio.get(any)).thenAnswer((_) async => Response(data:jsonDecode(githubResult) ,statusCode: 200));
      final future = datasource.getSearch('searchText');
      expect(future, completes);
  });

  test('deve retornar erro se statuscode nao for 200', () async{
    when(dio.get(any)).thenAnswer((_) async => Response(data: null ,statusCode: 401));
    final future = datasource.getSearch('searchText');
    expect(future, throwsA(isA<DatasourceError>()));
  });

  test('deve retornar Exception se tiver um erro no Dio', () async{
    when(dio.get(any)).thenThrow(Exception());
    final future = datasource.getSearch('searchText');
    expect(future, throwsA(isA<Exception>()));
  });

}
