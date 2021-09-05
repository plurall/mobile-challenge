
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/modules/user_search/infra/datasources/user_search_datasource.dart';
import 'package:mobile_challenge/app/modules/user_search/infra/models/user_result_search_model.dart';
import 'package:mobile_challenge/app/modules/user_search/infra/repositories/user_search_repository_impl.dart';
import 'package:mockito/mockito.dart';

class UserSearchDatasourceMock extends Mock implements UserSearchDatasource{}

void main(){
  final datasource = UserSearchDatasourceMock();
  final repository = UserSearchRepositoryImpl(datasource);

  test("Must return a UserSearch", () async {
    when(datasource.getSearch(any))
        .thenAnswer((_) async => UserResultSearchModel());
    final result = await repository.search("fajusto");
    expect(result | null, isA<UserResultSearchModel>());
  });

  test('Must return an DataSourceError if datasource fails', () async {
    when(datasource.getSearch(any)).thenThrow(Exception());
    final result = await repository.search("plural");
    expect(result.fold(id, id), isA<DataSourceError>());
  });
}