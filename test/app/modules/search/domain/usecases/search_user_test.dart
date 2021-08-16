import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/search/domain/entities/searched_user.dart';
import 'package:mobile_challenge/app/modules/search/domain/repositories/search_user_repository.dart';
import 'package:mobile_challenge/app/modules/search/domain/usecases/search_user.dart';
import 'package:mocktail/mocktail.dart';

class SearchUserRepositoryMock extends Mock implements SearchUserRepository{}

void main() {
  test('Should return a list of SearchedUser', () async {
    final searchText = "random_text";
    final repository = SearchUserRepositoryMock();
    final usecase = SearchUserImpl(repository);

    when(() => repository.search(searchText)).thenAnswer((_) async => <SearchedUser>[]);

    final result = await usecase.search(searchText);

    expect(result, isA<List<SearchedUser>>());
  });
}