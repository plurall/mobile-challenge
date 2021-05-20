import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/github/domain/repositories/github_repository.dart';
import 'package:mobile_challenge/features/github/domain/usecases/save_user_usecase.dart';
import 'package:mockito/mockito.dart';

class MockGithubRepository extends Mock implements GithubRepository {}

void main() {
  SaveUserUseCase usecase;
  MockGithubRepository mockGithubRepository;

  setUp(() {
    mockGithubRepository = MockGithubRepository();
    usecase = SaveUserUseCase(mockGithubRepository);
  });

  final tUser = UserEntity(
    id: 43092867,
    login: "FabioXimenes",
    name: "Fábio Ximenes",
    email: "fabio.ximenes@test.com",
    avatarUrl: "https://avatars.githubusercontent.com/u/43092867?v=4",
    bio: "test bio",
    location: "test location",
  );

  test(
    'should call saveUser from the repository',
    () async {
      // arrange
      when(mockGithubRepository.saveUser(any))
          .thenAnswer((_) async => Right(true));
      // act
      final result = await usecase(tUser);
      // assert
      expect(result, Right(true));
      verify(mockGithubRepository.saveUser(tUser));
      verifyNoMoreInteractions(mockGithubRepository);
    },
  );
}
