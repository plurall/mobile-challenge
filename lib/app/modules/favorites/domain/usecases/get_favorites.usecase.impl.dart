import 'package:mobile_challenge/app/modules/favorites/domain/repositories/get_favorites.repository.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:dartz/dartz.dart';
import 'get_favorites.usecase.dart';

class GetFavoritesUsecaseImpl implements GetFavoritesUsecase {
  final GetFavoritesRepository _repository;
  GetFavoritesUsecaseImpl(this._repository);

  @override
  Future<Either<Exception, List<UserEntity>>> call() {
    return _repository();
  }
}
