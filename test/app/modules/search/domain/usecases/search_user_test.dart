import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/user/features/search/domain/entities/searched_user_entity.dart';
import 'package:mobile_challenge/app/modules/user/features/search/domain/errors/search_errors.dart';
import 'package:mobile_challenge/app/modules/user/features/search/domain/repositories/search_user_repository.dart';
import 'package:mobile_challenge/app/modules/user/features/search/domain/usecases/search_user.dart';
import 'package:mocktail/mocktail.dart';

class SearchUserRepositoryMock extends Mock implements SearchUserRepository{}

void main() {
  late final SearchUserRepository repository;
  late final SearchUser usecase;

  setUpAll(() {
    repository = SearchUserRepositoryMock();
    usecase = SearchUserImpl(repository);
  });

  test('Should return a list of SearchedUser', () async {
    final searchText = "random_text";
    when(() => repository.search(searchText)).thenAnswer((_) async => <SearchedUserEntity>[]);

    final result = await usecase.search(searchText);

    expect(result, isA<List<SearchedUserEntity>>());
  });

  test('Should throw and InvalidSearchText if search text is empty', () async {
    final emptySearchText = "";

    final future = usecase.search(emptySearchText);

    expect(future, throwsA(isA<InvalidSearchText>()));
  });
}