import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/app_module.dart';
import 'package:mobile_challenge/app/modules/user_search/domain/usecases/search_by_user_login.dart';
import 'package:mobile_challenge/app/modules/user_search/external/github_user_datasource.dart';
import 'package:mobile_challenge/app/modules/user_search/infra/repositories/user_search_repository_impl.dart';
import 'package:mobile_challenge/app/modules/user_search/presentation/states/state.dart';
import 'package:mobile_challenge/app/modules/user_search/presentation/user_search_store.dart';
import 'package:mobile_challenge/app/modules/user_search/utils/github_user_response.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();
  Modular.init(AppModule());
  Modular.initialModule.changeBinds([
    Bind((i) => dio),
    Bind((i) => GithubUserDatasource(i())),
    Bind((i) => UserSearchRepositoryImpl(i())),
    Bind((i) => SearchByUserLoginImpl(i())),
    Bind((i) => UserSearchStore(i())),
  ]);

  when(dio.get(any)).thenAnswer((_) async => Response(
      data: jsonDecode(githubUserResponse), statusCode: 200, requestOptions: null));

  test('Must return a UserSuccessState', () async {
    var store = Modular.get<UserSearchStore>();
    var result = await store.makeSearch("fajusto");
    expect(result, isA<UserSearchSuccess>());
  });

  test('Must change state to UserSuccessState', () async {
    var store = Modular.get<UserSearchStore>();
    await store.stateReaction("fajusto");
    expect(store.state, isA<UserSearchSuccess>());
  });
}
