import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:mobile_challenge/app/modules/users/domain/repositories/do_favorite_user.repository.dart';

import 'do_favorite_user.usecase.dart';

class DoFavoriteUserUsecaseImpl implements DoFavoriteUserUsecase {
  final DoFavoriteUserRepository _repository;
  DoFavoriteUserUsecaseImpl(this._repository);

  @override
  Future<Either<Exception, void>> call(UserEntity entity) {
    return _repository(entity);
  }
}
