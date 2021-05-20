import 'package:mobile_challenge/core/errors/exceptions.dart';
import 'package:mobile_challenge/core/network/network_info.dart';
import 'package:mobile_challenge/features/github/data/datasources/github_local_data_source.dart';
import 'package:mobile_challenge/features/github/data/datasources/github_remote_data_source.dart';
import 'package:mobile_challenge/features/github/domain/entities/users_entity.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:mobile_challenge/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/features/github/domain/repositories/github_repository.dart';
import 'package:meta/meta.dart';

class GithubRepositoryImpl implements GithubRepository {
  final GithubRemoteDataSource remoteDataSource;
  final GithubLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  GithubRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> getUser(String username) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.getUser(username);
        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final user = await localDataSource.getCachedUser(username);
        return Right(user);
      } on CacheException {
        return Left(OfflineFailure());
      }
    }
  }

  @override
  Future<Either<Failure, UsersEntity>> getUsersWithName(String name) async {
    if (await networkInfo.isConnected) {
      try {
        final users = await remoteDataSource.getUsersWithName(name);
        return Right(users);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UsersEntity>> getBookmarkedUsers() async {
    try {
      final users = await localDataSource.getBookmarkedUsers();
      return Right(users);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveUser(UserEntity user) async {
    await localDataSource.saveUser(user);
    return Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> removeUserFromBookmarks(String username) async {
    try {
      await localDataSource.removeUser(username);
      return Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
