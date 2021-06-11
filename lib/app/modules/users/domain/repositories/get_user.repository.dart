import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';

abstract class GetUserRepository {
  Future<Either<Exception, UserEntity>> call(int id);
}
