import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/modules/users/domain/repositories/remove_favorite_user.repository.dart';
import 'package:mobile_challenge/app/modules/users/domain/usecases/remove_favorite_user.usecase.dart';

class RemoveFavoriteUserUsecaseImpl implements RemoveFavoriteUserUsecase {
  final RemoveFavoriteUserRepository _repository;
  RemoveFavoriteUserUsecaseImpl(this._repository);

  @override
  Future<Either<Exception, void>> call(int id) {
    return _repository(id);
  }
}
