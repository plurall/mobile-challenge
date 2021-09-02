import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/data/models/user.dart';
import 'package:mobile_challenge/data/repositories/search_remote.dart';
import 'package:mobile_challenge/domain/usecases/get_user/get_user_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_test.mocks.dart';

@GenerateMocks([SearchRemoteRepository])
void main() {
  MockSearchRemoteRepository repository = MockSearchRemoteRepository();
  GetUserUseCase useCase = GetUserUseCase(repository);

  String login = 'test';
  User user = User(
    id: 1,
    login: 'test',
    name: 'test name',
    avatar: '',
    email: 'test@mail.com',
    location: 'Brasil',
    bio: 'bio',
  );

  test('should get a user from get user in repository', () async {
    when(repository.getUser(login)).thenAnswer((_) async => Right(user));
    final response = await useCase.call(login);
    expect(response, Right(user));
  });
}
