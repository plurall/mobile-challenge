import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/core/errors/failures.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/github/domain/entities/users_entity.dart';

abstract class GithubRepository {
  Future<Either<Failure, UsersEntity>> getUsersWithName(String name);
  Future<Either<Failure, UserEntity>> getUser(String username);
  Future<Either<Failure, UsersEntity>> getBookmarkedUsers();
  Future<Either<Failure, bool>> saveUser(UserEntity user);
  Future<Either<Failure, bool>> removeUserFromBookmark(String username);
}