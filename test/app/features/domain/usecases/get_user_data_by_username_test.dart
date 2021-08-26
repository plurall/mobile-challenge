import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/features/domain/entities/user.dart';
import 'package:mobile_challenge/app/features/domain/repositories/users_repository.dart';
import 'package:mobile_challenge/app/features/domain/usecases/get_user_data_by_username.dart';
import 'package:mocktail/mocktail.dart';

class UsersRepositoryMock extends Mock implements UsersRepository {}

void main() {
  final repository = UsersRepositoryMock();
  final getUserDataByUserName = GetUserDataByUsername(repository);
  test('Should return the user data', () async {
    when(() => repository.getUser(any()))
        .thenAnswer((_) async => Right(User(username: 'any_username')));
    final result = await getUserDataByUserName(UserParams(username: 'Alex'));
    expect(result, isA<Right>());
    expect(result.fold(id, id), isA<User>());
  });

  test('Should throws an exception if username is invalid', () async {
    when(() => repository.getUser(any()))
        .thenAnswer((_) async => Left(InvalidUsernameFailure()));
    final result = await getUserDataByUserName(UserParams(username: ''));
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidUsernameFailure>());
  });
}
