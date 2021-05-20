import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/core/domain/usecases/usecase.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/github/domain/entities/users_entity.dart';
import 'package:mobile_challenge/features/github/domain/repositories/github_repository.dart';
import 'package:mobile_challenge/features/github/domain/usecases/get_bookmarked_users_usecase.dart';
import 'package:mockito/mockito.dart';

class MockGithubRepository extends Mock implements GithubRepository {}

void main() {
  GetBookmarkUsersUseCase usecase;
  MockGithubRepository mockGithubRepository;

  setUp(() {
    mockGithubRepository = MockGithubRepository();
    usecase = GetBookmarkUsersUseCase(mockGithubRepository);
  });

  final tUsers = UsersEntity(
    users: [
      UserEntity(
        id: 41808,
        login: "fabio",
        avatarUrl: "https://avatars.githubusercontent.com/u/41808?v=4",
        name: "test name 1",
        email: "test email 1",
        bio: "test bio 1",
        location: "test location 1",
      ),
      UserEntity(
        id: 1812093,
        login: "fabiospampinato",
        avatarUrl: "https://avatars.githubusercontent.com/u/1812093?v=4",
        name: "test name 2",
        email: "test email 2",
        bio: "test bio 2",
        location: "test location 2",
      ),
      UserEntity(
        id: 43092867,
        login: "FabioXimenes",
        name: "Fábio Ximenes",
        email: "fabio.ximenes@test.com",
        avatarUrl: "https://avatars.githubusercontent.com/u/43092867?v=4",
        bio: "test bio",
        location: "test location",
      ),
      UserEntity(
        id: 28530,
        login: "fabiomcosta",
        avatarUrl: "https://avatars.githubusercontent.com/u/28530?v=4",
        name: "test name 3",
        email: "test email 3",
        bio: "test bio 3",
        location: "test location 3",
      ),
    ],
  );

  test(
    'should get cached UsersEntity from the repository',
    () async {
      // arrange
      when(mockGithubRepository.getBookmarkedUsers())
          .thenAnswer((_) async => Right(tUsers));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tUsers));
      verify(mockGithubRepository.getBookmarkedUsers());
      verifyNoMoreInteractions(mockGithubRepository);
    },
  );
}
