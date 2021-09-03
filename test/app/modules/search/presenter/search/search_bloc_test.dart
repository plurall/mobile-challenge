import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/search/domain/entities/result_search.dart';
import 'package:mobile_challenge/app/modules/search/domain/usecases/search_by_text.dart';
import 'package:mobile_challenge/app/modules/search/presentation/search/search_bloc.dart';
import 'package:mobile_challenge/app/modules/search/presentation/search/states/state.dart';
import 'package:mockito/mockito.dart';

class SearchByTextMock extends Mock implements SearchByText {}

main() {
  final usecase = SearchByTextMock();
  final bloc = SearchBloc(usecase);

  test("Must return states on the correct order", () {
    when(usecase.call(any)).thenAnswer((_) async => Right(<ResultSearch>[]));
    expect(
        bloc,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchSuccess>(),
        ]));
    bloc.add("fajusto");
  });
}
