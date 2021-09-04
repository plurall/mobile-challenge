import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/search/domain/entities/result_search.dart';
import 'package:mobile_challenge/app/modules/search/domain/errors/errors.dart';
import 'package:mobile_challenge/app/modules/search/domain/repositories/search_repository.dart';
import 'package:mobile_challenge/app/modules/search/domain/usecases/search_by_text.dart';
import 'package:mockito/mockito.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

main() {
  final repository = SearchRepositoryMock();
  final usecase = SearchByTextImpl(repository);

  test('Must return a ResultSearch list', () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));
    final result = await usecase("plural");
    expect(result | null, isA<List<ResultSearch>>());
  });

  test('Must return an exception if it is an invalid text', () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));
    var result = await usecase(null);
    expect(result.fold(id, id), isA<InvalidTextError>());
  });

}