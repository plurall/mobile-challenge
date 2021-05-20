import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/github/domain/entities/users_entity.dart';
import 'package:mobile_challenge/features/github/domain/repositories/github_repository.dart';
import 'package:mobile_challenge/features/github/domain/usecases/get_users_with_name_usecase.dart';
import 'package:mockito/mockito.dart';

class MockGithubRepository extends Mock implements GithubRepository {}

void main() {
  MockGithubRepository mockGithubRepository;
  GetUsersWithNameUseCase usecase;

  setUp(() {
    mockGithubRepository = MockGithubRepository();
    usecase = GetUsersWithNameUseCase(mockGithubRepository);
  });

  final tName = 'test';
  final tUsers = UsersEntity(
    users: [
      UserEntity(
        id: 1,
        login: 'login',
        name: 'test name',
        email: 'email',
        avatarUrl: 'avatarUrl',
        bio: 'bio',
        location: 'location',
      ),
      UserEntity(
        id: 2,
        login: 'login',
        name: 'test name',
        email: 'email',
        avatarUrl: 'avatarUrl',
        bio: 'bio',
        location: 'location',
      ),
    ],
  );

  test(
    'should get UsersEntity for the name from the repository ',
    () async {
      // arrange
      when(mockGithubRepository.getUsersWithName(any))
          .thenAnswer((_) async => Right(tUsers));
      // act
      final result = await usecase(tName);
      // assert
      expect(result, Right(tUsers));
      verify(mockGithubRepository.getUsersWithName(tName));
      verifyNoMoreInteractions(mockGithubRepository);
    },
  );
}
