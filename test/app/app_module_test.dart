import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/app_module.dart';
import 'package:mobile_challenge/app/app_widget.dart';
import 'package:mobile_challenge/app/modules/search/domain/usecases/search_by_text.dart';
import 'package:mobile_challenge/app/modules/user_search/domain/usecases/search_by_user_login.dart';
import 'package:mobile_challenge/app/modules/user_search/infra/models/user_result_search_model.dart';
import 'package:mobile_challenge/app/modules/user_search/utils/github_user_response.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();

  runApp(ModularApp(
    module: AppModule(),
    child: AppWidget(),
  ));

  test('Must retrieve the usecase with no error', () {
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearchByTextImpl>());
  });

  test('Must retrieve the usecase with no error, user search module', () {
    final usecase = Modular.get<SearchByUserLogin>();
    expect(usecase, isA<SearchByUserLoginImpl>());
  });

  test('Must return a UserResultSearchModel', () async {
    when(dio.get(any)).thenAnswer((realInvocation) async => Response(
        data: githubUserResponse,
        statusCode: 200,
        requestOptions: null,
    ));

    final usecase = Modular.get<SearchByUserLogin>();
    final result = await usecase("fajusto");

    expect(result | null, isA<UserResultSearchModel>());
  });
}
