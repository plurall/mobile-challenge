import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/user/domain/entities/user_detail_entity.dart';
import 'package:mobile_challenge/app/modules/user/domain/errors/search_errors.dart';
import 'package:mobile_challenge/app/modules/user/domain/repositories/search_user_repository.dart';
import 'package:mobile_challenge/app/modules/user/domain/usecases/search_user.dart';
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
    when(() => repository.search(searchText)).thenAnswer((_) async => <UserDetailEntity>[]);

    final result = await usecase(searchText);

    expect(result, isA<List<UserDetailEntity>>());
  });

  test('Should throw and InvalidSearchText if search text is empty', () async {
    final emptySearchText = "";

    final future = usecase(emptySearchText);

    expect(future, throwsA(isA<InvalidSearchText>()));
  });
}