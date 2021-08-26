import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/features/domain/entities/result_search.dart';
import 'package:mobile_challenge/app/features/domain/repositories/search_repository.dart';
import 'package:mobile_challenge/app/features/domain/usecases/search_by_text.dart';
import 'package:mocktail/mocktail.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

void main() {
  final repository = SearchRepositoryMock();
  final searchByText = SearchByText(repository);
  test('Should return a list of result search', () async {
    when(() => repository.search(any()))
        .thenAnswer((_) async => Right(<ResultSearch>[]));
    final result = await searchByText(SearchParams(query: 'Alex'));
    expect(result, isA<Right>());
    expect(result | [], isA<List<ResultSearch>>());
  });

  test('Should throws an exception if text is invalid', () async {
    when(() => repository.search(any()))
        .thenAnswer((_) async => Left(InvalidTextFailure()));
    final result = await searchByText(SearchParams(query: ''));
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidTextFailure>());
  });
}
