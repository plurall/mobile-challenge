import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/github/domain/repositories/github_repositoy.dart';
import 'package:mobile_challenge/features/github/domain/usecases/get_user_usecase.dart';
import 'package:mockito/mockito.dart';

class MockGithubRepository extends Mock implements GithubRepository {}

void main() {
  MockGithubRepository mockGithubRepository;
  GetUserUseCase usecase;

  setUp(() {
    mockGithubRepository = MockGithubRepository();
    usecase = GetUserUseCase(mockGithubRepository);
  });

  final tUsername = 'test';
  final tUser = UserEntity(
    id: 1,
    login: 'test',
    name: 'name',
    email: 'email',
    avatarUrl: 'avatarUrl',
    bio: 'bio',
    location: 'location',
  );

  test(
    'should get UserEntity from the repository',
    () async {
      // arrange
      when(mockGithubRepository.getUser(any))
          .thenAnswer((_) async => Right(tUser));
      // act
      final result = await usecase(tUsername);
      // assert
      expect(result, Right(tUser));
      verify(mockGithubRepository.getUser(tUsername));
      verifyNoMoreInteractions(mockGithubRepository);
    },
  );
}
