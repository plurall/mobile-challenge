import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app_module.dart';
import 'package:mobile_challenge/modules/search/domain/entities/result_search.dart';
import 'package:mobile_challenge/modules/search/domain/usercases/search_by_text.dart';
import 'package:mockito/mockito.dart';
import 'modules/search/utils/github_response.dart';

class DioMock extends Mock implements Dio {}

main (){

  final dio = DioMock();

  Modular.init(AppModule());

  test('Deve recuperar o usecase sem erro', (){
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearchByTexteImpl>());
  });

  test('Deve trazer uma lista de ResultSearch', () async {
    when(dio.get(any)).thenAnswer(
            (_) async => Response(data: jsonDecode(githubResult), statusCode: 200));
    final usecase = Modular.get<SearchByText>();
    final result = await usecase("Ivanaldo");

    expect(result | null, isA<List<ResultSearch>>());
  });
}