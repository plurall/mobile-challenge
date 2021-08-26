import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/features/domain/entities/user.dart';
import 'package:mobile_challenge/app/features/domain/repositories/users_repository.dart';
import 'package:mobile_challenge/app/features/domain/usecases/save_favorite_user.dart';
import 'package:mocktail/mocktail.dart';

class UsersRepositoryMock extends Mock implements UsersRepository {}

void main() {
  final repository = UsersRepositoryMock();
  final saveFavoriteUser = SaveFavoriteUser(repository);
  final user = User(username: 'any_user');
  test('Should save favorite user on cache', () async {
    when(() => repository.saveFavoriteUser(user)).thenAnswer(
      (_) async => Right(true),
    );
    final result = await saveFavoriteUser(
      SaveUserParams(user: user),
    );
    expect(result, isA<Right>());
  });
}
