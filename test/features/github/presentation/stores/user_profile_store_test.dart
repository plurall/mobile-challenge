import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/core/constants/app_failures_messages.dart';
import 'package:mobile_challenge/core/errors/failures.dart';
import 'package:mobile_challenge/features/github/data/models/users_model.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/github/domain/usecases/get_bookmarked_users_usecase.dart';
import 'package:mobile_challenge/features/github/domain/usecases/get_user_usecase.dart';
import 'package:mobile_challenge/features/github/domain/usecases/remove_user_from_bookmarks_usecase.dart';
import 'package:mobile_challenge/features/github/domain/usecases/save_user_usecase.dart';
import 'package:mobile_challenge/features/github/presentation/stores/user_profile_store.dart';
import 'package:mockito/mockito.dart';
import 'package:mobx/mobx.dart' as mobx;

import '../../../../core/presentation/stores/mock_callable.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockGetUserUseCase extends Mock implements GetUserUseCase {}

class MockGetBookmarkUsersUseCase extends Mock
    implements GetBookmarkUsersUseCase {}

class MockRemoveUserFromBookmarksUseCase extends Mock
    implements RemoveUserFromBookmarksUseCase {}

class MockSaveUserUseCase extends Mock implements SaveUserUseCase {}

void main() {
  UserProfileStore store;
  MockGetUserUseCase mockGetUserUseCase;
  MockGetBookmarkUsersUseCase mockGetBookmarkUsersUseCase;
  MockRemoveUserFromBookmarksUseCase mockRemoveUserFromBookmarksUseCase;
  MockSaveUserUseCase mockSaveUserUseCase;

  setUp(() {
    mockGetUserUseCase = MockGetUserUseCase();
    mockGetBookmarkUsersUseCase = MockGetBookmarkUsersUseCase();
    mockRemoveUserFromBookmarksUseCase = MockRemoveUserFromBookmarksUseCase();
    mockSaveUserUseCase = MockSaveUserUseCase();
    store = UserProfileStore(
      getUserUseCase: mockGetUserUseCase,
      getBookmarkUsersUseCase: mockGetBookmarkUsersUseCase,
      saveUserUseCase: mockSaveUserUseCase,
      removeUserFromBookmarksUseCase: mockRemoveUserFromBookmarksUseCase,
    );
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

  group('checkIfUserIsSaved', () {
    test(
      'should call getBookmarkUsersUseCase to check if user is cached and return [true] if user is cached',
      () async {
        final tUsername = 'FabioXimenes';
        // arrange
        when(mockGetBookmarkUsersUseCase(any)).thenAnswer(
          (_) async => Right(
            UsersModel.fromJson(json.decode(
              fixture('users_cached.json'),
            )),
          ),
        );
        // act
        await store.checkIfUserIsSaved(tUsername);
        // assert
        expect(store.isSaved, true);
      },
    );

    test(
      'should call getBookmarkUsersUseCase to check if user is cached and return [false] if user is NOT cached',
      () async {
        final tUsername = 'john';
        // arrange
        when(mockGetBookmarkUsersUseCase(any)).thenAnswer(
          (_) async => Right(
            UsersModel.fromJson(json.decode(
              fixture('users_cached.json'),
            )),
          ),
        );
        // act
        await store.checkIfUserIsSaved(tUsername);
        // assert
        expect(store.isSaved, false);
      },
    );

    test(
      'should call getBookmarkUsersUseCase to check if user is saved and return [false] if there is NO USER CACHED',
      () async {
        final tUsername = 'john';
        // arrange
        when(mockGetBookmarkUsersUseCase(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // act
        await store.checkIfUserIsSaved(tUsername);
        // assert
        expect(store.isSaved, false);
      },
    );
  });

  group('removeUserFromBookmarks', () {
    test(
      'should remove bookmark for username',
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
        store.userEntity = tUser;
        store.isSaved = true;
        when(mockRemoveUserFromBookmarksUseCase(any))
            .thenAnswer((_) async => Right(unit));
        // act
        await store.removeUserFromBookmarks();
        // assert
        expect(store.isSaved, false);
        verify(mockRemoveUserFromBookmarksUseCase(tUser.login));
      },
    );
  });

  group('saveUser', () {
    test(
      'should call SaveUserUseCase to store user in cache',
      () async {
        // arrange
        when(mockSaveUserUseCase(any)).thenAnswer((_) async => Right(unit));
        final tUser = UserEntity(
          id: 1,
          login: 'test',
          name: 'name',
          email: 'email',
          avatarUrl: 'avatarUrl',
          bio: 'bio',
          location: 'location',
        );
        store.isSaved = false;
        store.userEntity = tUser;
        // act
        await store.saveUser();
        // assert
        expect(store.isSaved, true);
        verify(mockSaveUserUseCase(tUser));
      },
    );
  });
}
