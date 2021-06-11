import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';

abstract class GetSearchUsersUsecase {
  Future<Either<Exception, List<UserEntity>>> call(String search, int page);
}
