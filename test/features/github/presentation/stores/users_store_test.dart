import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/core/errors/failures.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/github/domain/entities/users_entity.dart';
import 'package:mobile_challenge/features/github/domain/usecases/get_users_with_name_usecase.dart';
import 'package:mobile_challenge/features/github/presentation/stores/users_store.dart';
import 'package:mockito/mockito.dart';
import 'package:mobx/mobx.dart' as mobx;

import '../../../../core/presentation/stores/mock_callable.dart';

class MockGetUsersWithNameUseCase extends Mock
    implements GetUsersWithNameUseCase {}

void main() {
  MockGetUsersWithNameUseCase mockGetUsersWithNameUseCase;
  UsersStore store;

  setUp(() {
    mockGetUsersWithNameUseCase = MockGetUsersWithNameUseCase();
    store = UsersStore(mockGetUsersWithNameUseCase);
  });

  test(
    'initial status should be Idle',
    () async {
      // assert
      expect(store.status, isA<Idle>());
    },
  );

  group('getUsersWithName', () {
    final tName = 'test';

    test('should return [Error] when the input is empty', () async {
      // arrange
      final tInvalidName = '';
      final statusChanged = MockCallable<UsersStatus>();
      mobx.reaction<UsersStatus>(
          (_) => store.status, (newValue) => statusChanged(newValue));
      // act
      await store.getUsersWithName(tInvalidName);
      // assert
      verifyInOrder([
        statusChanged(Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
      ]);
    });

    test(
      'should get data from the get users use case',
      () async {
        // arrange
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

        final statusChanged = MockCallable<UsersStatus>();
        mobx.reaction<UsersStatus>(
            (_) => store.status, (newValue) => statusChanged(newValue));

        when(mockGetUsersWithNameUseCase(any))
            .thenAnswer((_) async => Right(tUsers));
        // act
        await store.getUsersWithName(tName);
        // assert
        expect(store.users, tUsers);
        verifyInOrder([
          statusChanged(Loading()),
          statusChanged(Loaded()),
        ]);
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        final statusChanged = MockCallable<UsersStatus>();
        mobx.reaction<UsersStatus>(
            (_) => store.status, (newValue) => statusChanged(newValue));

        when(mockGetUsersWithNameUseCase(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // act
        await store.getUsersWithName(tName);
        // assert
        expect(store.users, null);
        verifyInOrder([
          statusChanged(Loading()),
          statusChanged(Error(message: SERVER_FAILURE_MESSAGE)),
        ]);
      },
    );
  });
}
