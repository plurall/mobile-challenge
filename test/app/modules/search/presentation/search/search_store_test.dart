import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/app_module.dart';
import 'package:mobile_challenge/app/modules/search/domain/usecases/search_by_text.dart';
import 'package:mobile_challenge/app/modules/search/external/datasources/github_datasource.dart';
import 'package:mobile_challenge/app/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:mobile_challenge/app/modules/search/presentation/search/search_store.dart';
import 'package:mobile_challenge/app/modules/search/presentation/search/states/state.dart';
import 'package:mobile_challenge/app/modules/search/utils/github_response.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();

  Modular.init(AppModule());
  Modular.initialModule.changeBinds([
    Bind((i) => dio),
    Bind((i) => GithubDatasource(i())),
    Bind((i) => SearchRepositoryImpl(i())),
    Bind((i) => SearchByTextImpl(i())),
    Bind((i) => SearchStore(i())),
  ]);

  when(dio.get(any)).thenAnswer(
          (_) async => Response(
              data: jsonDecode(githubResult),
              statusCode: 200,
              requestOptions: null
          ));

  test('Must return a SuccessState', () async {
    var store = Modular.get<SearchStore>();
    var result = await store.makeSearch("text");
    expect(result, isA<SearchSuccess>());
  });

  test('Must change state to SuccessState', () async {
    var store = Modular.get<SearchStore>();
    await store.stateReaction("text");
    expect(store.state, isA<SearchSuccess>());
  });
}