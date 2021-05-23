import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/core/error/error.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_entity.dart';

abstract class ISearchUserRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers(String text);
}
