import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/search/domain/entities/result_search.dart';
import 'package:mobile_challenge/app/modules/search/domain/errors/errors.dart';
import 'package:mobile_challenge/app/modules/search/infra/datasources/search_datasource.dart';
import 'package:mobile_challenge/app/modules/search/infra/models/result_search_model.dart';
import 'package:mobile_challenge/app/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:mockito/mockito.dart';

class SearchDataSourceMock extends Mock implements SearchDatasource {}

main() {
  final datasource = SearchDataSourceMock();
  final repository = SearchRepositoryImpl(datasource);

  test('Must return a ResultSearch list', () async {
    when(datasource.getSearch(any))
        .thenAnswer((_) async => <ResultSearchModel>[]);
    final result = await repository.search("plural");
    expect(result | null, isA<List<ResultSearch>>());
  });

  test('Must return an DataSourceError if datasource fails', () async {
    when(datasource.getSearch(any)).thenThrow(Exception());
    final result = await repository.search("plural");
    expect(result.fold(id, id), isA<DataSourceError>());
  });
}
