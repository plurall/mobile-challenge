import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/core/errors/exceptions.dart';
import 'package:mobile_challenge/core/errors/failures.dart';
import 'package:mobile_challenge/core/network/network_info.dart';
import 'package:mobile_challenge/features/github/data/datasources/github_local_data_source.dart';
import 'package:mobile_challenge/features/github/data/datasources/github_remote_data_source.dart';
import 'package:mobile_challenge/features/github/data/models/user_model.dart';
import 'package:mobile_challenge/features/github/data/models/users_model.dart';
import 'package:mobile_challenge/features/github/data/repositories/github_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockGithubRemoteDataSource extends Mock
    implements GithubRemoteDataSource {}

class MockGithubLocalDataSource extends Mock implements GithubLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  GithubRepositoryImpl repository;
  MockGithubRemoteDataSource mockGithubRemoteDataSource;
  MockGithubLocalDataSource mockGithubLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockGithubRemoteDataSource = MockGithubRemoteDataSource();
    mockGithubLocalDataSource = MockGithubLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = GithubRepositoryImpl(
      remoteDataSource: mockGithubRemoteDataSource,
      localDataSource: mockGithubLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getUser', () {
    final tUsername = 'test';
    final tUserModel = UserModel(
      id: 1,
      login: 'test',
      name: 'test',
      email: 'test@email',
      avatarUrl: 'test avatar',
      bio: 'test bio',
      location: 'test location',
    );
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getUser(tUsername);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockGithubRemoteDataSource.getUser(any))
              .thenAnswer((_) async => tUserModel);
          // act
          final result = await repository.getUser(tUsername);
          // assert
          verify(mockGithubRemoteDataSource.getUser(tUsername));
          expect(result, Right(tUserModel));
        },
      );

      test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockGithubRemoteDataSource.getUser(any))
              .thenThrow(ServerException());
          // act
          final result = await repository.getUser(tUsername);
          // assert
          verify(mockGithubRemoteDataSource.getUser(tUsername));
          expect(result, Left(ServerFailure()));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return cachedUser if when the device is offline and the user is cached',
        () async {
          // arrange
          when(mockGithubLocalDataSource.getCachedUser(any))
              .thenAnswer((_) async => tUserModel);
          // act
          final result = await repository.getUser(tUsername);
          // assert
          verifyZeroInteractions(mockGithubRemoteDataSource);
          expect(result, Right(tUserModel));
        },
      );

      test(
        'should return OfflineFailure when the device is offline and there is no cache for the user',
        () async {
          when(mockGithubLocalDataSource.getCachedUser(any))
              .thenThrow(CacheException());
          // act
          final result = await repository.getUser(tUsername);
          // assert
          verifyZeroInteractions(mockGithubRemoteDataSource);
          expect(result, Left(OfflineFailure()));
        },
      );
    });
  });

  group('getUsersWithName', () {
    final tName = 'fabio';
    final tUsersModel = UsersModel(
      users: [
        UserModel(
          id: 41808,
          login: "fabio",
          avatarUrl: "https://avatars.githubusercontent.com/u/41808?v=4",
          name: null,
          email: null,
          bio: null,
          location: null,
        ),
        UserModel(
          id: 1812093,
          login: "fabiospampinato",
          avatarUrl: "https://avatars.githubusercontent.com/u/1812093?v=4",
          name: null,
          email: null,
          bio: null,
          location: null,
        ),
        UserModel(
          id: 28530,
          login: "fabiomcosta",
          avatarUrl: "https://avatars.githubusercontent.com/u/28530?v=4",
          name: null,
          email: null,
          bio: null,
          location: null,
        ),
      ],
    );

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getUsersWithName(tName);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockGithubRemoteDataSource.getUsersWithName(any))
              .thenAnswer((_) async => tUsersModel);
          // act
          final result = await repository.getUsersWithName(tName);
          // assert
          verify(mockGithubRemoteDataSource.getUsersWithName(tName));
          expect(result, Right(tUsersModel));
        },
      );

      test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockGithubRemoteDataSource.getUsersWithName(any))
              .thenThrow(ServerException());
          // act
          final result = await repository.getUsersWithName(tName);
          // assert
          verify(mockGithubRemoteDataSource.getUsersWithName(tName));
          expect(result, Left(ServerFailure()));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return OfflineFailure when the device is offline',
        () async {
          // act
          final result = await repository.getUsersWithName(tName);
          // assert
          verifyZeroInteractions(mockGithubRemoteDataSource);
          expect(result, Left(OfflineFailure()));
        },
      );
    });
  });

  group('getBookmarkedUsers', () {
    test(
      'should return bookmarked users from local data source',
      () async {
        // arrange
        final tUsers = UsersModel.fromJson(json.decode(
          fixture('users_cached.json'),
        ));
        when(mockGithubLocalDataSource.getBookmarkedUsers())
            .thenAnswer((_) async => UsersModel.fromJson(
                  json.decode(fixture('users_cached.json')),
                ));
        // act
        final result = await repository.getBookmarkedUsers();
        // assert
        expect(result, Right(tUsers));
      },
    );

    test(
      'should return CacheFailure if there is no user cached',
      () async {
        // arrange
        when(mockGithubLocalDataSource.getBookmarkedUsers())
            .thenThrow(CacheException());
        // act
        final result = await repository.getBookmarkedUsers();
        // assert
        expect(result, Left(CacheFailure()));
      },
    );
  });

  group('saveUser', () {
    test(
      'should call local data source to save user',
      () async {
        // arrange
        final tUserModel = UserModel(
          id: 1,
          login: 'test',
          name: 'test',
          email: 'test@email',
          avatarUrl: 'test avatar',
          bio: 'test bio',
          location: 'test location',
        );
        when(mockGithubLocalDataSource.saveUser(any))
            .thenAnswer((_) async => unit);
        // act
        final result = await repository.saveUser(tUserModel);
        // assert
        expect(result, Right(unit));
      },
    );
  });

  group('removeUserFromBookmarks', () {
    final tUsername = 'test';
    test(
      'should remove user from bookmarks when the user is cached',
      () async {
        // arrange
        when(mockGithubLocalDataSource.removeUser(any))
            .thenAnswer((_) async => unit);
        // act
        final result = await repository.removeUserFromBookmarks(tUsername);
        // assert
        expect(result, Right(unit));
      },
    );

    test(
      'should return CacheFailure when the user is not cached',
      () async {
        // arrange
        when(mockGithubLocalDataSource.removeUser(any))
            .thenThrow(CacheException());
        // act
        final result = await repository.removeUserFromBookmarks(tUsername);
        // assert
        expect(result, Left(CacheFailure()));
      },
    );
  });
}
