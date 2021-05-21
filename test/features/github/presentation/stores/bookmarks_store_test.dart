import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/core/constants/app_failures_messages.dart';
import 'package:mobile_challenge/core/domain/usecases/usecase.dart';
import 'package:mobile_challenge/core/errors/failures.dart';
import 'package:mobile_challenge/features/github/data/models/users_model.dart';
import 'package:mobile_challenge/features/github/domain/entities/users_entity.dart';
import 'package:mobile_challenge/features/github/domain/usecases/get_bookmarked_users_usecase.dart';
import 'package:mobile_challenge/features/github/presentation/stores/bookmarks_store.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mockito/mockito.dart';

import '../../../../core/presentation/stores/mock_callable.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockGetBookmarkUsersUseCase extends Mock
    implements GetBookmarkUsersUseCase {}

void main() {
  BookmarksStore store;
  MockGetBookmarkUsersUseCase mockGetBookmarkUsersUseCase;

  setUp(() {
    mockGetBookmarkUsersUseCase = MockGetBookmarkUsersUseCase();
    store = BookmarksStore(
      getBookmarkUsersUseCase: mockGetBookmarkUsersUseCase,
    );
  });

  test(
    'initial status should be [Idle]',
    () async {
      // assert
      expect(store.bookmarksStatus, Idle());
    },
  );

  group('getBookmarkedUsers', () {
    test(
      'should get users from getBookmarkedUsers and emit [Loading, Loaded]',
      () async {
        // arrange
        final tUsers =
            UsersModel.fromJson(json.decode(fixture('users_cached.json')));

        final statusChanged = MockCallable<BookmarksStatus>();
        mobx.reaction<BookmarksStatus>((_) => store.bookmarksStatus,
            (newValue) => statusChanged(newValue));

        when(mockGetBookmarkUsersUseCase(NoParams())).thenAnswer(
          (_) async => Right(
            UsersModel.fromJson(
              json.decode(fixture('users_cached.json')),
            ),
          ),
        );
        // act
        await store.getBookmarkedUsers();
        // assert
        expect(store.usersEntity, tUsers);
        verifyInOrder([
          statusChanged(Loading()),
          statusChanged(Loaded()),
        ]);
      },
    );

    test(
      'should emit [Loading, Error] when there is no user cached',
      () async {
        // arrange
        final statusChanged = MockCallable<BookmarksStatus>();
        mobx.reaction<BookmarksStatus>((_) => store.bookmarksStatus,
            (newValue) => statusChanged(newValue));

        when(mockGetBookmarkUsersUseCase(NoParams())).thenAnswer(
          (_) async => Left(CacheFailure()),
        );
        // act
        await store.getBookmarkedUsers();
        // assert
        expect(store.usersEntity, UsersEntity(users: []));
        verifyInOrder([
          statusChanged(Loading()),
          statusChanged(Error(message: AppFailureMessages.NO_USER_CACHED)),
        ]);
      },
    );
  });
}
