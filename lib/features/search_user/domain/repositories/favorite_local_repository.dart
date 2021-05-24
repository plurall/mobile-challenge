import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/core/error/failures.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_detail_entity.dart';

abstract class IFavoriteLocalRepository {
  Future<Either<Failure, void>> saveFavoriteLocalUser(
    UserDetailEntity userDetailEntity,
  );

  Future<Either<Failure, List<UserDetailEntity>>> showFavoriteLocalUsers();
}
