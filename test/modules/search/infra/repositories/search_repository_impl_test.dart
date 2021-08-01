import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/modules/search/domain/entities/result_search.dart';
import 'package:mobile_challenge/modules/search/domain/errors/errors.dart';
import 'package:mobile_challenge/modules/search/infra/datasources/search_datasource.dart';
import 'package:mobile_challenge/modules/search/infra/models/result_search_model.dart';
import 'package:mobile_challenge/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:mockito/mockito.dart';

class SearchDatasourceMock extends Mock implements SearchDatasource{

}

main(){
  final dataSource = SearchDatasourceMock();
  final repository = SearchRepositoryImpl(dataSource);

  test('deve retornar uma lista de ResultSearch',() async{
    when(dataSource.getSearch(any))
        .thenAnswer((_) async => <ResultSearchModel> []);
    final result = await repository.search('Cleverson');
    expect(result | null , isA<List<ResultSearch>>());
  });

  test('deve retornar DatasourceError se datasource falhar',() async{
    when(dataSource.getSearch(any))
        .thenThrow(Exception());
    final result = await repository.search('Cleverson');
    expect(result.fold(id,id),isA<DatasourceError>());
  });

}