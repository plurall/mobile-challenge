import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';

abstract class DoFavoriteUserUsecase {
  Future<Either<Exception, void>> call(UserEntity entity);
}
