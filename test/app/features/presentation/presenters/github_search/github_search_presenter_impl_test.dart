import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/features/data/models/result_search_model.dart';
import 'package:mobile_challenge/app/features/domain/entities/result_search.dart';
import 'package:mobile_challenge/app/features/domain/usecases/search_by_text.dart';
import 'package:mobile_challenge/app/features/presentation/presenters/github_search/github_search_presenter_impl.dart';
import 'package:mocktail/mocktail.dart';

class SearchByTextMock extends Mock implements SearchByText {}

void main() {
  final searchByText = SearchByTextMock();
  final presenter = GithubSearchPresenterImpl(
    searchByText,
  );

  final resultSearch = <ResultSearch>[
    ResultSearchModel(username: 'AlexOliveira123'),
  ];
  final searchParams = SearchParams(query: 'AlexOliveira123');

  tearDown(() {
    presenter.resultSearchList = null;
  });

  test('Should search by text with success', () async {
    when(() => searchByText(searchParams))
        .thenAnswer((_) async => Right(resultSearch));
    expect(presenter.resultSearchList, isNull);
    await presenter.searchUsers('AlexOliveira123');
    expect(presenter.resultSearchList!.length, equals(1));
    verify(() => searchByText(searchParams)).called(1);
  });

  test('Should occurs an error when search by text', () async {
    when(() => searchByText(SearchParams(query: ''))).thenAnswer(
        (_) async => Left(InvalidTextFailure(message: 'invalid_text')));
    expect(presenter.resultSearchList, isNull);
    expect(presenter.error, isNull);
    await presenter.searchUsers('');
    expect(presenter.resultSearchList, isEmpty);
    expect(presenter.error, equals('invalid_text'));
    verify(() => searchByText(SearchParams(query: ''))).called(1);
  });
}
