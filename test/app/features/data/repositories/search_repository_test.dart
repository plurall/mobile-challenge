import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/features/data/datasources/search_datasource.dart';
import 'package:mobile_challenge/app/features/data/models/result_search_model.dart';
import 'package:mobile_challenge/app/features/data/repositories/search_repository.dart';
import 'package:mobile_challenge/app/features/domain/entities/result_search.dart';
import 'package:mocktail/mocktail.dart';

class SearchDatasourceMock extends Mock implements SearchDatasource {}

void main() {
  final datasource = SearchDatasourceMock();
  final repository = SearchRepositoryImpl(datasource);

  test('Should return a ResultSearch list', () async {
    when(() => datasource.fetchSearch(any()))
        .thenAnswer((_) async => <ResultSearchModel>[]);
    final result = await repository.search('AlexOliveira123');
    expect(result | [], isA<List<ResultSearch>>());
  });

  test('Should return an DatasourceError if datasource fails', () async {
    when(() => datasource.fetchSearch(any())).thenThrow(DatasourceError());
    final result = await repository.search('AlexOliveira123');
    expect(result.fold(id, id), isA<DatasourceError>());
  });
}
