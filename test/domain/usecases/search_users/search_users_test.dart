import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/data/models/user.dart';
import 'package:mobile_challenge/domain/usecases/get_user/get_user_usecase.dart';
import 'package:mobile_challenge/domain/usecases/search_users/search_users_usecase.dart';
import 'package:mockito/mockito.dart';

import '../get_user/get_user_test.mocks.dart';

void main() {
  MockSearchRemoteRepository repository = MockSearchRemoteRepository();
  SearchUsersUseCase useCase = SearchUsersUseCase(repository);

  String search = 'test';

  List<User> users = [
    User(
      id: 1,
      login: 'test',
      name: 'test name',
      avatar: '',
      email: 'test@mail.com',
      location: 'Brasil',
      bio: 'bio',
    ),
    User(
      id: 2,
      login: 'test2',
      name: 'test2 name',
      avatar: '',
      email: 'test2@mail.com',
      location: 'Brasil',
      bio: 'bio',
    ),
  ];

  test('should get a list of users from search users in repository', () async {
    when(repository.searchUsers(search)).thenAnswer((_) async => Right(users));
    final response = await useCase.call(search);
    expect(response, Right(users));
  });
}
