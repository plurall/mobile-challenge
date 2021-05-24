import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/modules/search/domain/entities/result_search.dart';
import 'package:mobile_challenge/modules/search/domain/usercases/search_by_text.dart';
import 'package:mobile_challenge/modules/search/presenter/search/search_bloc.dart';
import 'package:mobile_challenge/modules/search/presenter/search/state.dart';
import 'package:mockito/mockito.dart';

class SearchByTextMock extends Mock implements SearchByText{}

main(){
  final usecase = SearchByTextMock();
  final bloc = SearchBloc(usecase);

  test('Deve retornar os estados na ordem correta', (){
    when(usecase.call(any)).thenAnswer((_) async => Right(<ResultSearch>[]));
    expect(bloc, emitsInOrder([
      isA<SearchLoading>(),
      isA<SearchSuccess>()
    ]));
    bloc.add("Ivanaldo");
  });
}