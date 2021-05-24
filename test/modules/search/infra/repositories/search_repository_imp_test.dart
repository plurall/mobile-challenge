import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/modules/search/domain/entities/result_search.dart';
import 'package:mobile_challenge/modules/search/domain/errors/errors.dart';
import 'package:mobile_challenge/modules/search/infra/datasources/search_datasouces.dart';
import 'package:mobile_challenge/modules/search/infra/models/result_search_model.dart';
import 'package:mobile_challenge/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:mockito/mockito.dart';



class SearchDataSourceMok extends Mock implements SearchDataSource {}

main(){
  final datasource = SearchDataSourceMok();
  final repository = SearchRepositoryImp(datasource);

  test('Deve retornar uma lista de ResultSearch', () async {
    when(datasource.getSearch(any))
        .thenAnswer((_) async => <ResultSearchModel>[]);
        final result = await repository.search("teste");
        expect(result | null, isA<List<ResultSearch>>());
  });

  test('Deve retornar um DataSourceError se o dataSource falhar', () async {
    when(datasource.getSearch(any)).thenThrow(Exception());
    final result = await repository.search("teste");
    expect(result.fold(id, id), isA<DataSourceError>());
  });

}