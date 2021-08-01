import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/modules/search/domain/entities/result_search.dart';
import 'package:mobile_challenge/modules/search/domain/errors/errors.dart';
import 'package:mobile_challenge/modules/search/domain/usecases/search_by_text.dart';
import 'package:mobile_challenge/modules/search/presenter/search/search_block.dart';
import 'package:mobile_challenge/modules/search/presenter/search/states/state.dart';
import 'package:mockito/mockito.dart';

class SearchByTextMock extends Mock implements SearchByText{}

main(){
  final usecase= SearchByTextMock();
  final bloc =  SearchBlock(usecase);
  test('deve retornar estados na ordem correta', (){
    when(usecase.call(any)).thenAnswer((_) async=> Right(<ResultSearch>[]));
    expect(bloc, emitsInOrder([
      isA<SearchLoading>(),
      isA<SearchSucces>(),
    ]));
    bloc.add('Cleverson');
  });

  test('deve retornar estados na ordem correta', (){
    when(usecase.call(any)).thenAnswer((_) async=> Left(InvalidTextError()));
    expect(bloc, emitsInOrder([
      isA<SearchLoading>(),
      isA<SearchError>(),
    ]));
    bloc.add('Cleverson');
  });
}