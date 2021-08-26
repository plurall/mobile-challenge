import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/features/domain/entities/user.dart';

abstract class UsersRepository {
  Future<Either<Failure, User>> getUser(String username);
  Future<Either<Failure, List<User>>> getFavoritesUsers();
  Future<Either<Failure, bool>> saveFavoriteUser(User user);
}
