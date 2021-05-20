import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/features/github/domain/repositories/github_repository.dart';
import 'package:mobile_challenge/features/github/domain/usecases/remove_user_from_bookmarks_usecase.dart';
import 'package:mockito/mockito.dart';

class MockGithubRepository extends Mock implements GithubRepository {}

void main() {
  RemoveUserFromBookmarksUseCase usecase;
  MockGithubRepository mockGithubRepository;

  setUp(() {
    mockGithubRepository = MockGithubRepository();
    usecase = RemoveUserFromBookmarksUseCase(mockGithubRepository);
  });

  final tUsername = 'fabio';

  test(
    'should ',
    () async {
      // arrange
      when(mockGithubRepository.removeUserFromBookmarks(any))
          .thenAnswer((_) async => Right(true));
      // act
      final result = await usecase(tUsername);
      // assert
      expect(result, Right(true));
      verify(mockGithubRepository.removeUserFromBookmarks(tUsername));
      verifyNoMoreInteractions(mockGithubRepository);
    },
  );
}
