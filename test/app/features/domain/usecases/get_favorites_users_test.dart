import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/usecase/usecase.dart';
import 'package:mobile_challenge/app/features/domain/entities/user.dart';
import 'package:mobile_challenge/app/features/domain/repositories/users_repository.dart';
import 'package:mobile_challenge/app/features/domain/usecases/get_favorites_users.dart';
import 'package:mocktail/mocktail.dart';

class UsersRepositoryMock extends Mock implements UsersRepository {}

void main() {
  final repository = UsersRepositoryMock();
  final getFavoritesUsers = GetFavoritesUsers(repository);
  final usersList = [User(username: 'any_user')];
  test('Should get favorites users list', () async {
    when(() => repository.getFavoritesUsers()).thenAnswer(
      (_) async => Right(usersList),
    );
    final result = await getFavoritesUsers(NoParams());
    expect(result, isA<Right>());
  });
}
