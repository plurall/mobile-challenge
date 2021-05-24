import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/modules/search/domain/entities/result_search.dart';
import 'package:mobile_challenge/modules/search/domain/errors/errors.dart';
import 'package:mobile_challenge/modules/search/domain/repositories/search_repository.dart';
import 'package:mobile_challenge/modules/search/domain/usercases/search_by_text.dart';
import 'package:mockito/mockito.dart';


class SearchRepositoryMok extends Mock implements SearchRepository {}

main(){

  final repository = SearchRepositoryMok();
  final usercase = SearchByTexteImpl(repository);
  
  test('Deve retornar uma lista de ResultSearch', () async{
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));
    final resut = await usercase("teste");
    expect(resut, isA<Right>());
    expect(resut | null, isA<List<ResultSearch>>());
    
  });

  test('Deve retornar um InvalidTextError caso o texto seja invalido', () async{
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));
    var resut = await usercase(null);
    expect(resut.fold( id, id), isA<InvalidTextError>());
    resut = await usercase("");
    expect(resut.fold( id, id), isA<InvalidTextError>());
  });
  
}