import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/app_module.dart';
import 'package:mobile_challenge/app/app_widget.dart';
import 'package:mobile_challenge/app/modules/user_search/presentation/states/state.dart';
import 'package:mobile_challenge/app/modules/user_search/presentation/user_search_store.dart';
import 'package:mobile_challenge/app/modules/user_search/utils/github_user_response.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

void main(){
  final dio = DioMock();

  runApp(ModularApp(module: AppModule(), child: AppWidget()));

  when(dio.get(any)).thenAnswer((_) async => Response(
    data: githubUserResponse,
    statusCode: 200,
    requestOptions: null
  ));

  test('Must return a UserSuccessState', () async{
    var store = Modular.get<UserSearchStore>();
    var result = await store.makeSearch("fajusto");
    expect(result, isA<UserSearchSuccess>());
  });

  test('Must change state to UserSuccessState', () async {
    var store = Modular.get<UserSearchStore>();
    await store.stateReaction("text");
    expect(store.state, isA<UserSearchSuccess>());
  });
}