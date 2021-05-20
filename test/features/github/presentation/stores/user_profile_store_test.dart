import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/core/constants/app_failures_messages.dart';
import 'package:mobile_challenge/core/errors/failures.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/github/domain/usecases/get_user_usecase.dart';
import 'package:mobile_challenge/features/github/presentation/stores/user_profile_store.dart';
import 'package:mockito/mockito.dart';
import 'package:mobx/mobx.dart' as mobx;

import '../../../../core/presentation/stores/mock_callable.dart';

class MockGetUserUseCase extends Mock implements GetUserUseCase {}

void main() {
  UserProfileStore store;
  MockGetUserUseCase mockGetUserUseCase;

  setUp(() {
    mockGetUserUseCase = MockGetUserUseCase();
    store = UserProfileStore(mockGetUserUseCase);
  });

  test(
    'initial status should be [Idle]',
    () async {
      // assert
      expect(store.userStatus, isA<Idle>());
    },
  );

  group('getUserInfo', () {
    final tUsername = 'test';
    test(
      'should get user info from getUserUseCase and emit [Loading, Loaded]',
      () async {
        // arrange
        final tUser = UserEntity(
          id: 1,
          login: 'test',
          name: 'name',
          email: 'email',
          avatarUrl: 'avatarUrl',
          bio: 'bio',
          location: 'location',
        );

        final statusChanged = MockCallable<UserStatus>();
        mobx.reaction<UserStatus>(
            (_) => store.userStatus, (newValue) => statusChanged(newValue));

        when(mockGetUserUseCase(any)).thenAnswer((_) async => Right(tUser));
        // act
        await store.getUserInfo(tUsername);
        // assert
        expect(store.userEntity, tUser);
        verifyInOrder([
          statusChanged(Loading()),
          statusChanged(Loaded()),
        ]);
      },
    );

    test(
      'should emit [Loading, Error] when getting user info fails',
      () async {
        // arrange
        final statusChanged = MockCallable<UserStatus>();
        mobx.reaction<UserStatus>(
            (_) => store.userStatus, (newValue) => statusChanged(newValue));

        when(mockGetUserUseCase(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // act
        await store.getUserInfo(tUsername);
        // assert
        verifyInOrder([
          statusChanged(Loading()),
          statusChanged(
              Error(message: AppFailureMessages.SERVER_FAILURE_MESSAGE)),
        ]);
      },
    );
  });
}
