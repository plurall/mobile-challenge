import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/app_module.dart';
import 'package:mobile_challenge/app/app_widget.dart';
import 'package:mobile_challenge/app/modules/search/presentation/search/search_store.dart';
import 'package:mobile_challenge/app/modules/search/presentation/search/states/state.dart';
import 'package:mobile_challenge/app/modules/search/utils/github_response.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  var dio = DioMock();

  runApp(ModularApp(module: AppModule(), child: AppWidget()));

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